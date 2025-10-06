export heures_de_pointe, lignes_critiques, taux_occupation_par_ligne, taux_occupation_par_ligne_heure
export stats_frequentation, variation_temporelle, comparaison_lignes, flux_passagers

"""
Heures avec le nombre total de passagers montés, pour identifier les pics.
"""
function heures_de_pointe(freqs::Vector{Frequentation})
    counts = Dict{Time, Int}()
    for f in freqs
        counts[f.heure] = get(counts, f.heure, 0) + f.montees
    end
    
    return counts
end

"""
La liste des lignes dont le taux d'occupation moyen dépasse le seuil.
"""
function lignes_critiques(freqs::Vector{Frequentation}, seuil::Float64=0.80)
    taux = taux_occupation_par_ligne(freqs)
    return [lid for (lid, t) in taux if t >= seuil]
end

"""
Taux moyen d'occupation par ligne
"""
function taux_occupation_par_ligne(freqs::Vector{Frequentation})
    lignes = unique(f.ligne_id for f in freqs)
    result = Dict{Int, Float64}()
    for lid in lignes
        subset = filter(f -> f.ligne_id == lid, freqs)
        result[lid] = round(mean([f.occupation_bus / f.capacite_bus for f in subset]), digits=2)
    end
    return result
end

"""
Taux moyen d'occupation par ligne et par heure
"""
function taux_occupation_par_ligne_heure(freqs::Vector{Frequentation})
    result = Dict{Int, Dict{Time, Float64}}()  # ligne_id => (heure => taux moyen)

    # Récupérer toutes les lignes et heures
    lignes = unique(f.ligne_id for f in freqs)
    heures  = unique(f.heure for f in freqs)

    for lid in lignes
        result[lid] = Dict{Time, Float64}()
        for h in heures
            subset = filter(f -> f.ligne_id == lid && f.heure == h, freqs)
            if !isempty(subset)
                # moyenne du taux d'occupation
                result[lid][h] = round(mean([f.occupation_bus / f.capacite_bus for f in subset]), digits=2)
            end
        end
    end

    return result
end

"""
    Afficher le taux par ligne en fonction du taux
"""
function afficher_taux_par_ligne(taux_par_heure::Dict{Time, Float64})
    # Trier les heures
    for (h, t) in sort(collect(taux_par_heure), by = x -> x[1])
        println(Dates.format(h, "HH:MM"), " → ", round(t*100, digits=1), "%")
    end
end

"""
Renvoie un résumé statistique général de la fréquentation :
- Moyenne, médiane, variance du nombre de montées
- Capacité moyenne utilisée
"""
function stats_frequentation(freqs::Vector{Frequentation})
    montees = [f.montees for f in freqs]
    occupation = [f.occupation_bus / f.capacite_bus for f in freqs]

    # Calcul heures de pointe
    heures = Dict{Time, Int}()
    for f in freqs
        t = Time(hour(f.heure), minute(f.heure))  # conversion sécurisée
        heures[t] = get(heures, t, 0) + f.montees
    end

    return Dict(
        "moyenne_montees" => mean(montees),
        "mediane_montees" => median(montees),
        "variance_montees" => var(montees),
        "taux_moyen_occupation" => mean(occupation),
        "heures_de_pointe" => sort(collect(heures), by = x -> x[2], rev=true)  # tri décroissant
    )
end



"""
Calcule la moyenne des montées par heure pour analyser les variations temporelles.
"""
function variation_temporelle(freqs::Vector{Frequentation})
    heures = Dict{Time, Vector{Int}}()
    for f in freqs
        # Crée un Time correct à partir de f.heure
        t = Time(hour(f.heure), minute(f.heure))
        push!(get!(heures, t, Int[]), f.montees)
    end
    # Retourne la moyenne des montées par heure
    return Dict(h => round(mean(v), digits=2) for (h, v) in heures)
end


"""
    comparaison_lignes(freqs)

Renvoie un dictionnaire avec le total des montées par ligne pour comparer la fréquentation.
"""
function comparaison_lignes(freqs::Vector{Frequentation})
    lignes = Dict{Int, Int}()
    for f in freqs
        lignes[f.ligne_id] = get(lignes, f.ligne_id, 0) + f.montees
    end
    return lignes
end

"""
Retourne le flux global de passagers montés et descendus par heure.
"""
function flux_passagers(freqs::Vector{Frequentation})
    flux = Dict{Time, Tuple{Int, Int}}()
    for f in freqs
        # Crée un Time correct à partir de l'heure et de la minute
        t = Time(hour(f.heure), minute(f.heure))
        montées, descentes = get(flux, t, (0, 0))
        flux[t] = (montées + f.montees, descentes + f.descentes)
    end
    return flux
end
