# 📊 Évaluation Projet de Groupe : Simulateur de Transport SOTRACO

## 🎯 Vue d'Ensemble du Projet

### Contexte

Vous allez développer en équipe un système d'optimisation pour le réseau de transport public de Ouagadougou (SOTRACO). Ce projet combine programmation Julia avancée, analyse de données réelles, et résolution de problèmes concrets affectant des milliers de Burkinabè quotidiennement.

### Objectifs 
Pédagogiques

- ✅ Travailler efficacement en équipe sur un projet complexe
- ✅ Analyser des données de transport réelles avec DataFrames.jl
- ✅ Optimiser des ressources selon la demande
- ✅ Présenter des solutions techniques de manière professionnelle
- ✅ Créer une démonstration vidéo convaincante

## 👥 Formation et Organisation des Équipes

### Composition des Équipes

- **Taille** : 2 étudiants par groupe (BINÔME OBLIGATOIRE)
- **Formation** : Libre choix de votre partenaire
- **Deadline formation** : Vendredi 6 septembre 2024 - Envoyez-moi les noms des deux membres
- **Format** : Email avec objet "Groupe SOTRACO - [Nom1] & [Nom2]"

### Répartition Recommandée des Responsabilités

#### Membre 1 : Développeur Backend & Optimisation

- **Responsabilités principales** :

  - Architecture du système et structures de données
  - Import/traitement des données CSV
  - Algorithmes d'optimisation des fréquences
  - Calcul des temps d'attente et métriques // A voir
  - Tests unitaires

- **Modules à développer** :
  - `types.jl` : Définition des structs
  - `io_operations.jl` : Import/export CSV
  - `optimisation.jl` : Algorithmes d'optimisation
  - `tests/` : Tests de validation

#### Membre 2 : Analyste de Données & Interface

- **Responsabilités principales** :

  - Analyses statistiques avec DataFrames
  - Identification des patterns de fréquentation  // A voir
  - Interface utilisateur interactive
  - Génération de rapports et visualisations
  - Documentation

- **Modules à développer** :
  - `analyse.jl` : Analyses de données
  - `visualisation.jl` : Graphiques et tableaux
  - `rapports.jl` : Génération de rapports
  - `main.jl` : Interface utilisateur

### Collaboration Obligatoire

- ✅ Code reviews mutuelles obligatoires
- ✅ Intégration conjointe des modules
- ✅ Chacun doit comprendre l'ensemble du projet

## 📅 Calendrier et Jalons

### Semaine 1 : Fondations (9-13 septembre)

**Lundi - Mercredi**

- [ ] Binômes déjà formés (deadline 6 septembre)
- [ ] Répartition des responsabilités entre les 2 membres
- [ ] Exploration des données fournies (lignes_bus.csv, arrets.csv, frequentation.csv)
- [ ] Création de la structure du projet
- [ ] Définition des types/structs principaux

```julia
struct Ligne
    id::Int
    nom::String
    arrets::Vector{Arret}
    distance_km::Float64
end
```

**Jeudi - Vendredi**

- [ ] Import des données CSV
- [ ] Fonctions de base (calcul distances, temps de trajet)
- [ ] Premier commit GitHub avec README

### Semaine 2 : Analyses et Optimisation (16-20 septembre)

**Lundi - Mercredi**

- [ ] Analyses de fréquentation (heures de pointe, taux d'occupation)
- [ ] Identification des lignes critiques
- [ ] Algorithme d'optimisation des fréquences
- [ ] Tests unitaires des fonctions principales

**Jeudi - Vendredi**

- [ ] Système de recommandations
- [ ] Génération de rapports automatiques
- [ ] Visualisations des données
- [ ] Documentation du code


### Semaine 3 : Finalisation et Présentation (23-30 septembre)

**Lundi - Mardi**

- [ ] Intégration finale de tous les modules
- [ ] Tests complets du système
- [ ] Optimisations et corrections de bugs
- [ ] Préparation du script vidéo

**Mercredi - Jeudi**

- [ ] Enregistrement des 2 vidéos individuelles
- [ ] Montage et sous-titrage si nécessaire
- [ ] Rédaction du rapport final commun
- [ ] Vérification croisée des présentations

**Vendredi 27-30 septembre**

- [ ] Finalisation et soumission complète

## 🎥 Exigences des Vidéos de Démonstration INDIVIDUELLES

### ⚠️ IMPORTANT : Chaque membre fait SA PROPRE vidéo

- **Nombre de vidéos** : 2 vidéos par groupe (une par membre)
- **Durée par vidéo** : 5-10 minutes MAXIMUM
- **Format** : MP4, résolution minimum 720p
- **Langue** : Français
- **Plateforme** : YouTube (non listé) ou Google Drive
- **Nomenclature** : `SOTRACO_[NomPrenom]_Groupe[X].mp4`

### Structure Obligatoire de CHAQUE Vidéo Individuelle

#### 1. Introduction (30 secondes)

```
"Bonjour, je suis [Nom Prénom], membre du groupe [X].
Mon partenaire est [Nom du partenaire].
Je vais vous présenter notre Simulateur de Transport SOTRACO
et mes contributions spécifiques au projet."
```

- Slide avec votre nom et celui de votre binôme
- Titre du projet visible

#### 2. Vue d'Ensemble du Projet (1 minute)

- Présentation rapide du problème SOTRACO
- Architecture générale de votre solution
- **IMPORTANT** : Mentionnez vos responsabilités principales

```
"Notre système optimise le réseau SOTRACO.
J'étais responsable de [vos modules spécifiques].
Mon partenaire a développé [ses modules]."
```

#### 3. Démonstration en Direct (3-4 minutes)

**OBLIGATOIRE : Montrer le système COMPLET qui fonctionne**
**PUIS mettre l'accent sur VOS contributions**

Scénario de démonstration :

```julia
# Montrer dans le terminal
julia> include("src/main.jl")
julia> lancer_systeme_sotraco()

========================================
   SOTRACO - Système d'Optimisation
========================================
1. Analyser la fréquentation
2. Optimiser les lignes
3. Générer un rapport
4. Visualiser le réseau
5. Recommandations

Choix: 1

[Montrer les résultats en temps réel]
```

Points à démontrer :

- [ ] Système complet fonctionnel (2 min)
- [ ] Focus sur VOS modules (2 min) :
  - Si Membre 1 : Montrer l'optimisation, les algorithmes, les tests
  - Si Membre 2 : Montrer les analyses, visualisations, rapports
- [ ] Expliquer votre code spécifique

#### 4. Mes Contributions Techniques (2 minutes)

**C'est ici que vous brillez individuellement !**

```
"Nos analyses révèlent que :
- La ligne 14 est surchargée entre 7h-9h
- 30% des bus sont sous-utilisés l'après-midi
- Un réajustement permettrait d'économiser 15% de carburant"
```

Détaillez VOS contributions spécifiques :

- Code que VOUS avez écrit
- Problèmes que VOUS avez résolus
- Décisions techniques que VOUS avez prises
- Résultats de VOS analyses ou optimisations

#### 5. Démonstration de Code Personnel (1-2 minutes)

Montrez et expliquez UN morceau de code important que VOUS avez écrit :

```julia
# Exemple : Si vous avez fait l'optimisation
function optimiser_frequence(ligne::Ligne, donnees::DataFrame)
    # Expliquez VOTRE logique
    heures_pointe = identifier_pics(donnees)
    nouvelle_freq = calculer_frequence_optimale(heures_pointe)
    return nouvelle_freq
end
```

Expliquez :

- Pourquoi cette approche
- Les défis rencontrés
- Comment vous les avez résolus

#### 6. Collaboration et Intégration (30 secondes)

Expliquez comment vous avez collaboré :

```
"J'ai intégré mes modules avec ceux de [partenaire].
Nous avons fait des code reviews mutuelles.
Les défis d'intégration étaient..."
```

#### 7. Conclusion et Apprentissages (30 secondes)

- Ce que VOUS avez appris personnellement
- Vos fiertés dans ce projet
- Lien vers le GitHub commun

## 📊 Grille d'Évaluation Détaillée (100 points)

### 1. Implémentation Technique (40 points)

#### Fonctionnalités Core (20 pts)

- [ ] **Modélisation du réseau** (5 pts)

  - Structs pour Lignes, Arrêts, Bus
  - Relations correctes entre entités
  - Gestion des horaires

- [ ] **Import/Export données** (5 pts)

  - Lecture des 3 fichiers CSV fournis
  - Validation et nettoyage
  - Export des résultats

- [ ] **Calculs de base** (5 pts)

  - Distances entre arrêts
  - Temps de trajet
  - Capacité et occupation

- [ ] **Interface utilisateur** (5 pts)
  - Menu interactif fonctionnel
  - Messages clairs en français
  - Gestion des erreurs

#### Optimisation (20 pts)

- [ ] **Analyse de fréquentation** (10 pts)

  - Identification heures de pointe
  - Taux d'occupation par ligne/heure
  - Flux de passagers // A voir

- [ ] **Algorithme d'optimisation** (10 pts)
  - Ajustement des fréquences
  - Réduction temps d'attente // A voir 
  - Amélioration du taux de remplissage

### 2. Analyse de Données (25 points)

- [ ] **Statistiques descriptives** (10 pts) // A voir

  - Moyennes, médianes de fréquentation
  - Variations temporelles
  - Comparaisons entre lignes

- [ ] **Insights pertinents** (10 pts) // A voir 

  - Au moins 3 découvertes significatives
  - Recommandations basées sur données
  - Identification de problèmes réels // A voir

- [ ] **Visualisations** (5 pts)
  - Au moins 2 visualisations claires
  - ASCII art accepté
  - Légendes et titres // A voir

### 3. Qualité des Présentations Vidéos Individuelles (20 points)

#### Évaluation de CHAQUE vidéo (10 pts par membre)

- [ ] **Respect du format individuel** (3 pts)

  - Durée 5-10 minutes
  - Présentation personnelle claire
  - Structure individuelle suivie

- [ ] **Démonstration des contributions** (5 pts)

  - Système complet montré
  - Focus clair sur SES contributions
  - Explication de SON code

- [ ] **Communication personnelle** (2 pts)
  - Explications claires
  - Français correct
  - Enthousiasme et professionnalisme

### 4. Travail en Binôme (15 points)

- [ ] **Organisation du binôme** (5 pts)

  - Répartition claire des responsabilités
  - Équilibre des contributions (50/50)
  - Synchronisation régulière

- [ ] **Contributions Git** (5 pts)

  - Commits équilibrés des 2 membres
  - Historique montrant la collaboration
  - Code reviews mutuelles visibles

- [ ] **Intégration** (5 pts)
  - Modules bien intégrés
  - Cohérence du code
  - Documentation partagée

### 5. Points Bonus (jusqu'à 10 points supplémentaires)

- [ ] **Fonctionnalités avancées** (+3 pts)

  - Prédiction de la demande
  - Carte interactive du réseau
  - API REST

- [ ] **Créativité** (+3 pts)

  - Solutions innovantes
  - Interface exceptionnelle
  - Analyses poussées

- [ ] **Impact social** (+2 pts)

  - Accessibilité handicapés
  - Tarification sociale
  - Écologie

- [ ] **Performance** (+2 pts)
  - Code optimisé
  - Tests de performance
  - Gestion de gros volumes

## 📝 Évaluation Individuelle

### Auto-Évaluation (À remplir par chaque membre)

```markdown
Nom : ********\_********
Partenaire : ********\_********
Responsabilités principales : ********\_********

1. Modules que j'ai développés :

   - [ ] ***
   - [ ] ***
   - [ ] ***

2. Pourcentage de ma contribution : **\_** %

3. Temps consacré au projet : **\_** heures

4. Défis techniques que j'ai résolus :

   ***

5. Ce que j'ai appris de cette collaboration :

   ***

6. Auto-évaluation de ma vidéo : \_\_\_/10
```

### Évaluation du Partenaire

Évaluez votre partenaire de binôme :

```markdown
Nom de votre partenaire : ********\_********

| Critère                 | Note /10 | Commentaire      |
| ----------------------- | -------- | ---------------- |
| Contribution technique  | \_\_\_   | ****\_\_\_\_**** |
| Respect des engagements | \_\_\_   | ****\_\_\_\_**** |
| Communication           | \_\_\_   | ****\_\_\_\_**** |
| Qualité du code         | \_\_\_   | ****\_\_\_\_**** |
| Esprit d'équipe         | \_\_\_   | ****\_\_\_\_**** |

Points forts de mon partenaire :

---

Points d'amélioration :

---
```

### Journal de Contributions Git

```bash
# Générer automatiquement
git log --author="Nom" --pretty=format:"%h - %an, %ar : %s" --since="3 weeks ago"
```

## 📤 Instructions de Soumission

### 1. Repository GitHub

- [ ] Repository partagé entre les 2 membres
- [ ] README.md complet avec :
  - Noms des 2 membres du binôme
  - Instructions d'installation
  - Guide d'utilisation
  - Liens vers les 2 vidéos individuelles

### 2. Structure du Repository

```
projet-sotraco-groupe-X/
├── README.md
├── Project.toml (dépendances Julia)
├── src/
│   ├── main.jl
│   ├── types.jl
│   ├── optimisation.jl
│   ├── analyse.jl
│   └── ...
├── data/
│   ├── lignes_bus.csv
│   ├── arrets.csv
│   └── frequentation.csv
├── test/
│   └── runtests.jl
├── docs/
│   ├── rapport_final.pdf
│   └── contributions_individuelles.md
└── resultats/
    ├── analyses.csv
    └── recommandations.txt
```

### 3. Vidéos de Démonstration Individuelles

- [ ] 2 vidéos séparées (une par membre)
- [ ] Uploadées sur YouTube (non listé) ou Google Drive
- [ ] Liens partagés dans le README
- [ ] Format des noms :
  - `SOTRACO_[NomPrenom1]_Groupe[X].mp4`
  - `SOTRACO_[NomPrenom2]_Groupe[X].mp4`

### 4. Rapport Final Commun (2-3 pages)

Format PDF rédigé ENSEMBLE contenant :

1. Résumé exécutif
2. Répartition du travail (qui a fait quoi)
3. Approche technique globale
4. Résultats et analyses
5. Recommandations pour SOTRACO
6. Conclusion et apprentissages

### 5. Checklist Finale

- [ ] Code source complet sur GitHub avec commits équilibrés
- [ ] Tests passent (`julia test/runtests.jl`)
- [ ] README avec liens vers les 2 vidéos individuelles
- [ ] 2 vidéos uploadées (format: `SOTRACO_[NomPrenom]_Groupe[X].mp4`)
- [ ] Rapport commun PDF (2-3 pages) dans `docs/`
- [ ] Évaluations individuelles complétées
- [ ] Tag v1.0 créé

## ⚠️ Mesures Anti-Plagiat

### Vérifications Automatiques

1. **Analyse des commits Git** : Historique vérifié
2. **Similarité de code** : Comparaison entre groupes
3. **Originalité des analyses** : Insights uniques requis

### Vérification des Vidéos Individuelles

Chaque vidéo sera évaluée sur :

- **Connaissance globale** : Compréhension du projet entier
- **Expertise spécifique** : Maîtrise de ses propres modules
- **Capacité d'explication** : Clarté des explications techniques
- **Authenticité** : Vérification que c'est bien son travail

Je pourrai demander des clarifications par email si nécessaire.

### Différenciation entre Binômes

Pour éviter le plagiat :

- Chaque binôme choisit 3-5 lignes différentes à analyser
- Focus sur des métriques différentes
- Vos analyses doivent refléter vos choix uniques
- Les vidéos individuelles révèleront la compréhension réelle

## 💡 Conseils pour Réussir

1. **Commencez simple** : Bases fonctionnelles avant optimisation
2. **DataFrames.jl** : Maîtrisez `groupby`, `combine`, `filter`
3. **Git efficace** : Branches séparées, commits réguliers, reviews mutuelles
4. **Vidéos différenciées** : Chacun montre SES contributions spécifiques
5. **Tests progressifs** : D'abord 10 lignes, puis le dataset complet

## 🎓 Barème Final

### Composition de la Note

- **40%** : Qualité technique du code
- **25%** : Analyses de données
- **20%** : Vidéos individuelles (10% chacune)
- **15%** : Travail en binôme et intégration

### Échelle de Notation

| Note | Pourcentage | Appréciation                                   |
| ---- | ----------- | ---------------------------------------------- |
| A+   | 90-100%     | Exceptionnel - Binôme parfaitement synchronisé |
| A    | 80-89%      | Excellent - Objectifs largement dépassés       |
| B    | 70-79%      | Très bien - Bon travail d'équipe               |
| C    | 60-69%      | Bien - Requirements atteints                   |
| D    | 50-59%      | Passable - Minimum fonctionnel                 |
| F    | <50%        | Insuffisant - Manque de collaboration          |

## 📅 Dates Importantes

- **6 septembre 2024** : Date limite pour l'envoi des noms du binôme par email
- **9-13 septembre** : Développement des modules de base
- **16-20 septembre** : Intégration et analyses de données
- **23-27 septembre** : Finalisation et enregistrement des vidéos
- **30 septembre 2024** : DATE LIMITE FINALE - Soumission complète

---

**Bon courage à tous les binômes !** 🇧🇫

**N'oubliez pas : 2 personnes, 2 vidéos, 1 projet commun !**
