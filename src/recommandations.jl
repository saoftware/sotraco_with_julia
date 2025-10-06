include("types.jl")
include("optimisation.jl")
include("analyse.jl")

export recommander_actions, generer_rapport_social_ecologique

"""
    recommander_actions(lignes::Vector{Ligne}, freqs::Vector{Frequentation}; seuil=0.75)

Retourne une liste de recommandations pour chaque ligne :
- "Augmenter fréquence" si taux moyen > seuil
- "Diminuer fréquence" si taux moyen < seuil/2
- "Maintenir fréquence" sinon
"""
function recommander_actions(lignes::Vector{Ligne}, freqs::Vector{Frequentation}; seuil=0.75)
    taux = Dict{Int, Float64}()
    for ligne in lignes
        subset = filter(f -> f.ligne_id == ligne.id, freqs)
        taux[ligne.id] = isempty(subset) ? 0.0 : mean([f.occupation_bus / f.capacite_bus for f in subset])
    end

    recommandations = Dict{Int,String}()
    for ligne in lignes
        t = taux[ligne.id]
        if t > seuil
            recommandations[ligne.id] = "Augmenter fréquence"
        elseif t < seuil/2
            recommandations[ligne.id] = "Diminuer fréquence"
        else
            recommandations[ligne.id] = "Maintenir fréquence"
        end
    end
    return recommandations
end

"""
Analyse l'impact des tarifs sur les revenus et l'accessibilité.
Retourne un dictionnaire avec :
- revenus_par_ligne : revenus totaux estimés par ligne
- revenu_total : revenus totaux du réseau
- lignes_eleve_tarif : lignes dont le tarif dépasse la moyenne
- lignes_faible_tarif : lignes dont le tarif est inférieur à la moyenne
"""
function analyse_tarification(freqs::Vector{Frequentation}, lignes::Vector{Ligne})
    # Calcul du revenu par ligne
    revenus_par_ligne = Dict{Int, Float64}()
    for ligne in lignes
        subset = filter(f -> f.ligne_id == ligne.id, freqs)
        revenu_ligne = sum(f.montees * ligne.tarif_fcfa for f in subset)
        revenus_par_ligne[ligne.id] = revenu_ligne
    end

    revenu_total = sum(values(revenus_par_ligne))

    # Tarifs moyens
    tarifs = [ligne.tarif_fcfa for ligne in lignes]
    tarif_moyen = mean(tarifs)

    lignes_eleve_tarif = [ligne.id for ligne in lignes if ligne.tarif_fcfa > tarif_moyen]
    lignes_faible_tarif = [ligne.id for ligne in lignes if ligne.tarif_fcfa < tarif_moyen]

    return Dict(
        "revenus_par_ligne" => revenus_par_ligne,
        "revenu_total" => revenu_total,
        "lignes_eleve_tarif" => lignes_eleve_tarif,
        "lignes_faible_tarif" => lignes_faible_tarif
    )
end


# --- Analyse accessibilité ---
function analyse_accessibilite(arrets::Vector{Arret})
    accessibles = [a for a in arrets if a.abribus && a.eclairage]
    nb_total = length(arrets)
    nb_accessibles = length(accessibles)
    pourcentage = nb_total == 0 ? 0.0 : nb_accessibles / nb_total * 100
    return Dict(
        "nb_accessibles" => nb_accessibles,
        "nb_total" => nb_total,
        "pourcentage_accessible" => pourcentage
    )
end

# --- Analyse écologique ---
function analyse_ecologique(lignes::Vector{Ligne}; facteur_emission::Float64=0.1)
    # facteur_emission = tonnes CO2/km par bus (hypothèse)
    total_km = sum(l.distance_km for l in lignes)
    empreinte = total_km * facteur_emission
    return Dict(
        "km_total" => total_km,
        "empreinte_CO2_tonnes" => empreinte
    )
end

# --- Génération rapport synthétique ---
function generer_rapport_social_ecologique(arrets::Vector{Arret}, lignes::Vector{Ligne}, freqs::Vector{Frequentation})
    s = "=== Rapport Social et Écologique SOTRACO ===\n\n"

    # Accessibilité
    access = analyse_accessibilite(arrets)
    s *= "Accessibilité des arrêts : $(access["nb_accessibles"])/$(access["nb_total"]) " *
         "($(round(access["pourcentage_accessible"], digits=1))%)\n"

    # Tarification
    tarif = analyse_tarification(freqs, lignes)
    s *= "Revenu total estimé : $(tarif["revenu_total"]) FCFA\n"
    s *= "Lignes au-dessus du tarif moyen : $(tarif["lignes_eleve_tarif"])\n"
    s *= "Lignes en dessous du tarif moyen : $(tarif["lignes_faible_tarif"])\n"

    # Écologie
    eco = analyse_ecologique(lignes)
    s *= "Distance totale parcourue par le réseau : $(eco["km_total"]) km\n"
    s *= "Empreinte carbone estimée : $(round(eco["empreinte_CO2_tonnes"], digits=2)) tonnes CO2\n"

    return s
end
