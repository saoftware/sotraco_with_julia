# ============================
# Structures de base
# ============================

"""
Arret : Représente un arrêt de bus.
"""
struct Arret
    id::Int
    nom_arret::String
    quartier::String
    zone::String
    latitude::Float64
    longitude::Float64
    abribus::Bool
    eclairage::Bool
    lignes_desservies::Vector{Int}
end

"""
Ligne : Représente une ligne de bus.
"""
struct Ligne
    id::Int
    nom_ligne::String
    origine::String
    destination::String
    distance_km::Float64
    duree_trajet_min::Int
    tarif_fcfa::Int
    frequence_min::Int
    statut::String
end

"""
Frequentation : Reprensente la fréquentation à un arrêt pour une ligne donnée.
"""
struct Frequentation
    id::Int
    date::Date
    heure::Time
    ligne_id::Int
    arret_id::Int
    montees::Int
    descentes::Int
    occupation_bus::Int
    capacite_bus::Int
end


"Représente un bus opérant sur une ligne donnée"
struct Bus
    id::Int
    ligne_id::Int
    capacite::Int
    conducteur::String
    heure_depart::Time
    position_actuelle::Union{Arret, Nothing}
end

"Horaires programmés pour une ligne donnée"
struct Horaire
    ligne_id::Int
    arret_id::Int
    heure_passage::Time
    jour::String
end