# Modules du projet

types.jl : définition des structures

io_operations.jl : import/export CSV

optimisation.jl : calcul distances, taux de remplissage, optimisation fréquence

analyse.jl : analyses statistiques

visualisation.jl : graphiques

rapports.jl : génération de rapports

recommandations.jl : suggestions pour ajuster fréquences

prediction : Pour le modèle de prédiction des demandes

transport_projet.jl : Pour l'import des modules du projet

### Installation et ajout les dépendances nécessaires
Dans l'emplacement du projet Exécuter la commande ci-dessous, Cela crée un environnement Julia local

Exécuter ces commandes dans re REPL Julia pour ajouter les dependances nécessaires au projet

julia --project=.

using Pkg

Pkg.add(
    [
        "CSV", 
        "DataFrames", 
        "Dates", 
        "Statistics", 
        "Plots",
        "MLJ", 
        "MLJLinearModels", 
        "BSON",
        "JSON3"
    ]
)
Pkg.add("FilePathsBase")
Pkg.add("Filesystem")

# Exécuter Tests Unitaires
A la racine du projet, exécuter la commande ci-après : julia --project=. tests/runtests.jl

# Exécuter le projet
julia --project=.
include("main.jl")
lancer_systeme_sotraco()
