using CSV

export charger_arrets, charger_frequentation, charger_lignes

"""
Chargement du fichier CSV des arrêts.
"""
function charger_arrets(path::String)
    df = CSV.read(path, DataFrame)

    # Suppression des NA
    dropmissing!(df)
    df.latitude = parse.(Float64, replace.(string.(df.latitude), "," => "."))
    df.longitude = parse.(Float64, replace.(string.(df.longitude), "," => "."))
    
    # Conversion champs accessibles
    df.abribus = map(x -> x in ["Oui", "oui", "OUI", "1", 1], df.abribus)
    df.eclairage = map(x -> x in ["Oui", "oui", "OUI", "1", 1], df.eclairage)

    # Conversion des lignes desservies
    df.lignes_desservies = [parse.(Int, split(strip(s), ",")) for s in string.(df.lignes_desservies)]

    return [Arret(
                row.id,
                row.nom_arret,
                row.quartier,
                row.zone,
                row.latitude,
                row.longitude,
                row.abribus,
                row.eclairage,
                row.lignes_desservies
            ) for row in eachrow(df)]
end

"""
Chargement du CSV des lignes de bus
"""
function charger_lignes(path::String)
    df = CSV.read(path, DataFrame)

    dropmissing!(df)

    # Nettoyage des chiffres
    df.distance_km = parse.(Float64, replace.(string.(df.distance_km), "," => "."))
    df.duree_trajet_min = parse.(Float64, replace.(string.(df.duree_trajet_min), "," => "."))
    df.tarif_fcfa = parse.(Int, replace.(string.(df.tarif_fcfa), "," => ""))
    df.frequence_min = parse.(Float64, replace.(string.(df.frequence_min), "," => "."))

    return [Ligne(
                row.id,
                row.nom_ligne,
                row.origine,
                row.destination,
                row.distance_km,
                row.duree_trajet_min,
                row.tarif_fcfa,
                row.frequence_min,
                row.statut
            ) for row in eachrow(df)]
end

"""
Chargement du fichier CSV des fréquentations.
"""
function charger_frequentation(path::String)
    df = CSV.read(path, DataFrame)
    dropmissing!(df)

    return [Frequentation(
                row.id,
                isa(row.date, Date) ? row.date : Date(row.date, "yyyy-mm-dd"),
                isa(row.heure, Time) ? row.heure : Time(row.heure, "HH:MM"),
                row.ligne_id,
                row.arret_id,
                row.montees,
                row.descentes,
                row.occupation_bus,
                row.capacite_bus
            ) for row in eachrow(df)]
end
