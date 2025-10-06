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


end



println("\n")
println("Tous les tests unitaires passent")
