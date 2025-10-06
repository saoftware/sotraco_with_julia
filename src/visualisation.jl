using  Plots
export plot_heures_de_pointe, plot_occupation_lignes


function plot_heures_de_pointe(freqs)
    counts = TransportProjet.heures_de_pointe(freqs)
    heures = sort(collect(keys(counts)))
    valeurs = [counts[h] for h in heures]
    p = bar(
        string.(heures), valeurs,
        title = "Heures de pointe du réseau",
        xlabel = "Heure",
        ylabel = "Passagers montés",
        label = "Heures de pointe",
        xrotation = 45
    )
    return p
end

function plot_occupation_lignes(freqs)
    taux = TransportProjet.taux_occupation_par_ligne(freqs)
    lignes = sort(collect(keys(taux)))
    valeurs = [round(taux[l]*100, digits=1) for l in lignes]
    p = bar(
        string.(lignes), valeurs,
        title = "Taux moyen d'occupation par ligne (%)",
        xlabel = "Lignes",
        ylabel = "Occupation (%)",
        label = "Taux d'occupation",
        ylim = (0, 100)
    )
    return p
end
