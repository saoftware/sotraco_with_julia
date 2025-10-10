using CSV, DataFrames, Dates, Statistics
using MLJ, MLJLinearModels, FilePathsBase
using BSON

export arrets_to_json, export_model

function export_model()
    df = CSV.read("data/frequentation.csv", DataFrame)

    # features
    df.hour = hour.(df.heure)
    df.weekday = dayofweek.(df.date)
    df.is_weekend = (df.weekday .>= 6)

    # target
    y = df.montees

    # simple one-hot pour ligne_id (ou utiliser encoding MLJ)
    X = select(df, [:hour, :weekday, :is_weekend, :ligne_id])

    # modèle MLJ
    Linear = @load LinearRegressor pkg = MLJLinearModels
    model = Linear()
    mach = machine(model, X, y)
    fit!(mach)

    # créer le dossier si besoin
    if !isdir("modeles")
        mkdir("modeles")
    end

    # sauvegarder le modèle
    BSON.@save "modeles/demande_model.bson" mach
    println("Modèle enregistré avec succès !")

end

function arrets_to_json(arrets::Vector{TransportProjet.Arret}, outpath::String)
    features = []
    for a in arrets
        push!(features, Dict(
            "type" => "Feature",
            "properties" => Dict(
                "id" => a.id,
                "nom" => a.nom_arret,
                "quartier" => a.quartier
            ),
            "geometry" => Dict(
                "type" => "Point",
                "coordinates" => [a.longitude, a.latitude]
            )
        ))
    end
    geo = Dict("type" => "FeatureCollection", "features" => features)
    open(outpath, "w") do io
        JSON3.write(io, geo)
    end
end
