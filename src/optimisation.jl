export distance_arrets, distance_totale_ligne, taux_remplissage, vitesse_moyenne_arrets, temps_trajet_arrets, optimiser_frequences

"""
Calcule la distance en km entre deux points géographiques
"""
function haversine(lat1, lon1, lat2, lon2)
    R = 6371.0  # rayon de la Terre (km)
    dlat = deg2rad(lat2 - lat1)
    dlon = deg2rad(lon2 - lon1)
    a = sin(dlat/2)^2 + cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * sin(dlon/2)^2
    c = 2 * atan(sqrt(a), sqrt(1 - a))
    return R * c
end

"""
Calcule la distance entre deux arrêts.
"""
function distance_arrets(a1::Arret, a2::Arret)
    return haversine(a1.latitude, a1.longitude, a2.latitude, a2.longitude)
end

"""
Calcule la distance totale d'une ligne donnée
en additionnant les segments consécutifs.
"""
function distance_totale_ligne(arrets::Vector{Arret})
    d = 0.0
    for i in 1:(length(arrets) - 1)
        d += distance_arrets(arrets[i], arrets[i+1])
    end
    return d
end

"""
Calcule le taux moyen de remplissage des bus
sur un ensemble d'observations.
"""
function taux_remplissage(freqs::Vector{Frequentation})
    if isempty(freqs)
        return 0.0
    end
    ratios = [f.occupation_bus / f.capacite_bus for f in freqs if f.capacite_bus > 0]
    return mean(ratios)
end

"""
Calcul du vitesse moyenne entre deux arrêts en km/h.
- `temps_min` : temps réel de trajet en minutes
"""
function vitesse_moyenne_arrets(arret1::Arret, arret2::Arret, temps_min::Float64)
    dist = distance_arrets(arret1, arret2)  # km
    temps_h = temps_min / 60.0              # convertir en heures
    return dist / temps_h
end


"""
Calcul du temps de trajet (en minutes) entre deux arrêts en supposant une vitesse moyenne.
"""
function temps_trajet_arrets(arret1::Arret, arret2::Arret; vitesse_moyenne=20.0)
    dist = distance_arrets(arret1, arret2)  # km
    return dist / vitesse_moyenne * 60      # minutes
end


"""
Optimisation des frequences
"""
function optimiser_frequences(lignes::Vector{Ligne}, freqs::Vector{Frequentation}; seuil=0.75, min_freq=5, max_freq=30)
    # Calcul taux moyen par ligne
    taux = Dict{Int, Float64}()
    for ligne in lignes
        subset = filter(f -> f.ligne_id == ligne.id, freqs)
        if !isempty(subset)
            taux[ligne.id] = mean([f.occupation_bus / f.capacite_bus for f in subset])
        else
            taux[ligne.id] = 0.0
        end
    end

    # Ajustement fréquence
    nouvelles_freqs = Dict{Int, Int}()
    for ligne in lignes
        t = taux[ligne.id]
        freq = ligne.frequence_min

        if t > seuil
            # trop rempli -> diminuer l'intervalle entre bus
            freq = max(min_freq, Int(round(freq * (seuil / t))))
        elseif t < seuil / 2
            # peu rempli -> augmenter l'intervalle
            freq = min(max_freq, Int(round(freq * (seuil / max(t, 0.01)))))
        end

        nouvelles_freqs[ligne.id] = freq
    end

    return nouvelles_freqs
end
