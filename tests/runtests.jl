using Test, Dates
using Plots
include("../src/transport_projet.jl")
using .TransportProjet

println("=== Tests unitaires TransportProjet ===")

# --- Données factices pour tests ---
arret1 = TransportProjet.Arret(1, "A", "Quartier1", "Z1", 12.0, -1.0, true, true, [1, 2])
arret2 = TransportProjet.Arret(2, "B", "Quartier2", "Z2", 12.1, -1.1, false, true, [1])

ligne1 = TransportProjet.Ligne(1, "Ligne 1", "A", "B", 5.0, 15, 200, 10, "Actif")

freq1 = TransportProjet.Frequentation(1, Date(2023, 9, 26), Time(8, 0), 1, 1, 30, 5, 30, 60)
freq2 = TransportProjet.Frequentation(2, Date(2023, 9, 26), Time(8, 15), 1, 2, 20, 10, 25, 60)


# Création des fréquentations

arrets_test = [arret1, arret2]
freqs_test = [freq1, freq2]
lignes_test = [ligne1]

#  --- Test des fonctions du modules optimisation ---
println("\n")
@testset "Fonctions du module optimisation" begin

    # === distance_arrets ===
    @test isapprox(TransportProjet.distance_arrets(arret1, arret2), 15.55; atol=1.0)

    # === distance_totale_ligne ===
    @test TransportProjet.distance_totale_ligne(arrets_test) > 0

    # === taux_remplissage ===
    @test isapprox(TransportProjet.taux_remplissage(freqs_test), (30 + 25) / (60 + 60); atol=0.01)

    # --- Test vitesse_moyenne_arrets ---
    v = TransportProjet.vitesse_moyenne_arrets(arret1, arret2, 5.0)
    @test v > 0  # vérifie simplement que la vitesse est positive

    # --- Test temps d'un trajet ---
    temps = TransportProjet.temps_trajet_arrets(arret1, arret2)
    @test temps > 0

    # --- Test optimisation fréquence ---
    nouvelles = TransportProjet.optimiser_frequences(lignes_test, freqs_test; seuil=0.5, min_freq=5, max_freq=30)
    @test haskey(nouvelles, 1)
    @test nouvelles[1] <= 10 && nouvelles[1] >= 5
end

# --- Test des fonctions du modules analyse ---
println("\n")
@testset "Fonctions du module analyses" begin
    # Créons quelques données fictives de fréquentation
    f1 = TransportProjet.Frequentation(1, Date(2024, 9, 10), Time(8), 1, 1, 20, 5, 45, 50)  # 90% occupation
    f2 = TransportProjet.Frequentation(2, Date(2024, 9, 10), Time(8), 1, 2, 15, 3, 48, 50)  # 96% occupation
    f3 = TransportProjet.Frequentation(3, Date(2024, 9, 10), Time(18), 2, 3, 30, 10, 30, 60) # 50% occupation
    freqs = [f1, f2, f3]

    # === Test heures_de_pointe ===
    heures = TransportProjet.heures_de_pointe(freqs)
    @test heures[Time(8, 0)] == 35
    @test heures[Time(18, 0)] == 30

    # === Test lignes_critiques ===
    lc = TransportProjet.lignes_critiques(freqs)  # seuil = 70%
    @test 1 in lc      # Ligne 1 dépasse 90% moyenne
    @test !(2 in lc)   # Ligne 2 seulement 50%

    # === Test taux_occupation_par_ligne ===
    taux = TransportProjet.taux_occupation_par_ligne(freqs)
    @test isapprox(taux[1], (0.9 + 0.96) / 2; atol=0.01)
    @test isapprox(taux[2], 0.5; atol=0.01)
    
    # === Test taux_occupation_par_ligne_heure ===
    taux = TransportProjet.taux_occupation_par_ligne(freqs)
    @test isapprox(taux[1], (0.9 + 0.96) / 2; atol=0.01)
    @test isapprox(taux[2], 0.5; atol=0.01)

    # === Test taux_occupation_par_ligne_heure ===
    println("\n=== Taux occupation par ligne et heure ===")
    taux = TransportProjet.taux_occupation_par_ligne(freqs)
    @test isapprox(taux[1], (0.9 + 0.96) / 2; atol=0.01)
    @test isapprox(taux[2], 0.5; atol=0.01)
    
    
    stats = TransportProjet.stats_frequentation(freqs)
    variation_temp = TransportProjet.variation_temporelle(freqs)
    comparaison = TransportProjet.comparaison_lignes(freqs)
    flux = TransportProjet.flux_passagers(freqs)

    # === Vérif de stats descriptives ===
    @test haskey(stats, "moyenne_montees")
    @test stats["moyenne_montees"] > 0
    @test stats["taux_moyen_occupation"] <= 1

    @test length(variation_temp) > 0
    @test all(v -> v >= 0, values(variation_temp))

    @test all(v -> v >= 0, values(comparaison))

    @test length(flux) > 0
    @test all(v -> v[1] ≥ 0 && v[2] ≥ 0, values(flux))

    # === Exemple d’affichage lisible (facultatif) ===
    println("\n--- Résumé ---")
    println("Stats fréquence. : ", stats)
    println("Variation temp. : ", variation_temp)
    println("Comparaison lignes : ", comparaison)
    println("Flux passagers : ", flux)
    
end


# --- Test des fonctions du modules visualisation ---
println("\n")
@testset "Fonctions du module visualisation" begin
    f1 = TransportProjet.Frequentation(1, Date(2024, 9, 10), Time(8), 1, 1, 20, 5, 45, 50)
    f2 = TransportProjet.Frequentation(2, Date(2024, 9, 10), Time(8), 1, 2, 15, 3, 48, 50)
    f3 = TransportProjet.Frequentation(3, Date(2024, 9, 10), Time(18), 2, 3, 30, 10, 30, 60)
    freqs = [f1, f2, f3]

    p1 = TransportProjet.plot_heures_de_pointe(freqs)
    @test typeof(p1) <: Plots.Plot

    p2 = TransportProjet.plot_occupation_lignes(freqs)
    @test typeof(p2) <: Plots.Plot
end


# --- Test des fonctions du modules rapports ---
println("\n")
@testset "Fonctions du module rapports" begin
    # === Test generer_insights ===
    rapport= TransportProjet.generer_insights(lignes_test, freqs_test)
    for line in rapport
            println(line)
    end
end


# --- Test des fonctions du modules recommandations ---
println("\n")
@testset "Fonctions du module recommandations" begin
    # Appel de la fonction
    recs = TransportProjet.recommander_actions([ligne1], freqs_test)

    # Vérifications
    @test isa(recs, Dict)
    @test haskey(recs, 1)
    r = recs[1]
    @test isa(r, String)

end

println("\n")
println("Tous les tests unitaires passent")
