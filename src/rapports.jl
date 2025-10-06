include("types.jl")
include("analyse.jl")
include("recommandations.jl")

export generer_insights

"""
Analyse globale du réseau pour identifier :
    - Nombre d'observations
    - Taux d'occupation
    - Les lignes surchargées ou sous-utilisées
    - Les heures de pointe réelles
    - Recommandations
    - Les anomalies dans la fréquentation

Retourne un vecteur de chaînes de caractères contenant les insights.
"""
function generer_insights(lignes::Vector{Ligne}, freqs::Vector{Frequentation})
    insights = String[]

    push!(insights, "=== Rapport ===\n")

    # Lignes critiques
    critiques = lignes_critiques(freqs)
    if !isempty(critiques)
        push!(insights, "Lignes critiques (taux > 80%) : $(critiques)\n")
    end

    # Analyse du taux de remplissage
    taux = taux_occupation_par_ligne(freqs)
    surcharges = [id for (id, t) in taux if t > 0.9]
    faibles = [id for (id, t) in taux if t < 0.5]

    if !isempty(surcharges)
        push!(insights, "Les lignes $(surcharges) dépassent 90% de remplissage : risque de saturation, prévoir plus de bus.")
    end
    if !isempty(faibles)
        push!(insights, "Les lignes $(faibles) ont moins de 50% de remplissage : optimisation ou réduction à envisager.")
    end

    # Heures de pointe
    heures = heures_de_pointe(freqs)
    if !isempty(heures)
        pic_val = maximum(values(heures))
        pics = [h for (h, v) in heures if v == pic_val]
        push!(insights, "Heure(s) de pointe détectée(s) : $(pics) avec $pic_val passagers montés.")
    end

    # Anomalies de fréquentation (occupation > capacité)
    anomalies = [f for f in freqs if f.occupation_bus > f.capacite_bus]
    if !isempty(anomalies)
        push!(insights, "Anomalie détectée : certains bus dépassent leur capacité nominale.")
    end

    # Suggestion stratégique globale
    taux_global = mean([f.occupation_bus / f.capacite_bus for f in freqs])
    if taux_global > 0.80
        push!(insights, "Forte demande globale — envisager une extension de flotte ou de nouvelles lignes.")
    elseif taux_global < 0.6
        push!(insights, "Sous-utilisation du réseau — réévaluer la répartition des bus.")
    else
        push!(insights, "Équilibre satisfaisant entre l'offre et la demande.")
    end

    return insights
end

