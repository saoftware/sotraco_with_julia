using HTTP
using JSON3
using BSON

# === Charger le modèle entraîné ===
global mach
BSON.@load "modeles/demand_model.bson" mach

# === Fonction de prédiction ===
function predict_handler(req::HTTP.Request)
    try
        data = JSON3.read(String(req.body))
        println("Requête reçue : ", data)

        # Exemple : extraire les features d'entrée
        # (à adapter selon ton modèle)
        heure = data["heure"]
        jour = data["jour"]
        ligne = data["ligne"]

        # Faire une prédiction (à adapter à ton modèle MLJ)
        y_pred = predict(mach, [(heure=heure, jour=jour, ligne=ligne)])
        return HTTP.Response(200, JSON3.write(Dict("prediction" => y_pred)))
    catch e
        return HTTP.Response(400, JSON3.write(Dict("error" => string(e))))
    end
end

# === Lancer le serveur ===
"""
HTTP.serve() do req::HTTP.Request
    if req.target == "/predict" && req.method == "POST"
        return predict_handler(req)
    else
        return HTTP.Response(404, "Not Found")
    end
end |> x -> println("Serveur en écoute sur http://localhost:8000/predict")
"""
