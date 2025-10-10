include("src/transport_projet.jl")
using Plots   # nécessaire pour savefig
using Dates

function lancer_systeme_sotraco()
        println("Bienvenue dans le système de gestion SOTRACO")
        println("Chargement des données...\n")

        arrets = Vector{TransportProjet.Arret}()
        lignes = Vector{TransportProjet.Ligne}()
        freqs = Vector{TransportProjet.Frequentation}()

        try
                arrets = TransportProjet.charger_arrets("data/arrets.csv")
                lignes = TransportProjet.charger_lignes("data/lignes_bus.csv")
                freqs = TransportProjet.charger_frequentation("data/frequentation.csv")
        catch e
                println("Erreur lors du chargement des données : ", e)
                return
        end

        while true
                println("\n=== MENU PRINCIPAL ===")
                println("1. Analyse de fréquentation")
                println("2. Optimiser les lignes")
                println("3. Analyse de données")
                println("4. Générer un rapport complet")
                println("5. Visualiser les données")
                println("6. Recommandations")
                println("7. Fonctionnalités avancées")
                println("8. Impact social")
                println("9. Quitter")

                print("\nVotre choix : ")
                choix = try
                        parse(Int, readline())
                catch
                        println("Entrée invalide. Veuillez saisir un nombre entre 1 et 9.")
                        continue
                end

                try
                        if choix == 1
                                println("\nAnalyse de fréquentation...")
                                
                                println("\nAnalyse de données")
                                println("Arrêts : ", length(arrets))
                                println("Lignes : ", length(lignes))
                                println("Fréquentations : ", length(freqs))

                                heures = TransportProjet.heures_de_pointe(freqs)
                                lignes_critiques = TransportProjet.lignes_critiques(freqs)
                                taux_par_ligne = TransportProjet.taux_occupation_par_ligne(freqs)
                                taux_ligne_heure = TransportProjet.taux_occupation_par_ligne_heure(freqs)

                                println("\nHeures de pointes")
                                for (h, v) in heures
                                        println("Heure : ", Dates.format(h, "HH:MM"), " → Passagers : $v")
                                end
                                
                                println("\nLignes critiques : $lignes_critiques")
                                
                                println("\nTaux d'occupation par ligne")
                                for (lid, t) in taux_par_ligne
                                        println("Ligne $lid, → Taux occupation : $t")
                                end

                                println("\nTaux d'occupation par ligne et par heure")
                                for (lid, taux) in taux_ligne_heure
                                        println("\nLigne $lid → Taux d'occupation :")
                                        TransportProjet.afficher_taux_par_ligne(taux)
                                end

                                println("\nAnalyse de fréquentation terminée.")

                        elseif choix == 2
                                println("\nOptimisation des fréquences...")
                                nouvelles_freqs = TransportProjet.optimiser_frequences(lignes, freqs)
                                println("\n=== Fréquences optimisées ===")
                                for (lid, f) in nouvelles_freqs
                                        println("Ligne $lid : nouvelle fréquence = $f min")
                                end
                                println("\nOptimisation terminée.")


                        elseif choix == 3                                
                                println("\n===== Analyse de fréquentation =====")
                                stats = TransportProjet.stats_frequentation(freqs)
                                variation_temp = TransportProjet.variation_temporelle(freqs)
                                comparaison_lignes = TransportProjet.comparaison_lignes(freqs)
                                flux_passagers = TransportProjet.flux_passagers(freqs)

                                println("\nAnalyse descriptive : $stats")

                                println("\nVariation temporelle")
                                for (lid, f) in variation_temp
                                        println("Heure $lid : Taux = $f%")
                                end

                                println("\nComparaision des lignes")
                                for (lid, f) in comparaison_lignes
                                        println("Ligne $lid : Nombre passager = $f")
                                end

                                println("\nFlux par passager")
                                for (lid, f) in flux_passagers
                                        println("Heure $lid : Flux = $f")
                                end
                                println("\nAnalyse de données terminée.")

                        elseif choix == 4
                                println("\nGénération du rapport...")
                                rapport = TransportProjet.generer_insights(lignes, freqs)
                                for line in rapport
                                        println(line)
                                end

                                println("\nGéneration du rapport terminée.")

                        elseif choix == 5
                                println("\nGénération des visualisations...")
                                p1 = TransportProjet.plot_heures_de_pointe(freqs)
                                display(p1)
                                savefig(p1, "img/heures_de_pointe.png")

                                p2 = TransportProjet.plot_occupation_lignes(freqs)
                                display(p2)   # Affiche le graphique
                                savefig(p2, "img/occupation_lignes.png")
                                println("Graphiques générés.")

                                println("\nGénération de la visualisation terminée.")

                        elseif choix == 6
                                println("\nRecommandations du système...")
                                recs = TransportProjet.recommander_actions(lignes, freqs)
                                for (lid, r) in recs
                                        println("Ligne $lid → $r")
                                end

                                println("\nRecommandation du système terminée.")

                        elseif choix == 7
                                println("\n===== Fonctionnalités avancées =====")
                                println("\nPrédiction de la demande...")
                                arrets = TransportProjet.charger_arrets("data/arrets.csv")
                                TransportProjet.export_model()
                                TransportProjet.arrets_to_json(arrets, "modeles/arrets.geojson")
                                println("Fichier GeoJSON généré : arrets.geojson")
                                println("\nPrédiction de la demande terminée.")

                        elseif choix == 8
                                println("\nImpact social...")
                                rapport = TransportProjet.generer_rapport_social_ecologique(arrets, lignes, freqs)
                                
                                println(rapport)
                                println("\nImpact social terminée.")

                        elseif choix == 9
                                println("\nMerci d'avoir utilisé le système SOTRACO. À bientôt !")
                                break
                        else
                                println("Choix non reconnu. Veuillez sélectionner entre 1 et 6.")
                        end

                catch e
                        println("Une erreur s'est produite : ", e)
                end
        end
end