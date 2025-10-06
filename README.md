
# 🚌 Simulateur de Transport SOTRACO


## 📋 Description du Projet

Créez un système de simulation et d'optimisation pour le réseau de transport public de Ouagadougou (SOTRACO). Ce système analysera les données de fréquentation, optimisera les horaires, et fournira des insights pour améliorer le service.

## 🎯 Objectifs d'Apprentissage

À la fin de ce projet, vous saurez :
- ✅ Modéliser un réseau de transport complexe
- ✅ Analyser des données temporelles avec DataFrames
- ✅ Optimiser des ressources selon la demande
- ✅ Créer des visualisations de données géospatiales (ASCII)
- ✅ Calculer des métriques de performance transport

## 🌍 Contexte

SOTRACO est la société de transport en commun de Ouagadougou. Votre système aidera à :
- Optimiser les fréquences de bus selon la demande
- Identifier les heures et lignes de pointe  
- Réduire les temps d'attente des passagers
- Améliorer la rentabilité du réseau

## 📊 Données Fournies

### lignes_bus.csv (15 lignes)
- Lignes réelles de Ouagadougou
- Distances et durées de trajet
- Tarifs par ligne

### arrets.csv (50 arrêts)
- Arrêts géolocalisés de la ville
- Zones et équipements (abribus)
- Lignes desservant chaque arrêt

### frequentation.csv (2000+ enregistrements)
- Données horaires sur 30 jours
- Montées/descentes par arrêt
- Taux d'occupation des bus

## 🛠️ Fonctionnalités à Implémenter

### 1. Gestion du Réseau
- [ ] Modélisation lignes, arrêts, trajets
- [ ] Calcul distances et temps de parcours
- [ ] Capacité et fréquence des bus

### 2. Analyses de Fréquentation  
- [ ] Identification heures de pointe
- [ ] Taux d'occupation par ligne/heure
- [ ] Flux de passagers entre arrêts
- [ ] Analyse des pics de demande

### 3. Optimisation des Services
- [ ] Ajustement des fréquences
- [ ] Répartition optimale des bus
- [ ] Réduction temps d'attente moyen
- [ ] Maximisation taux de remplissage

### 4. Métriques de Performance
- [ ] Ponctualité des services  
- [ ] Temps d'attente par arrêt
- [ ] Rentabilité par ligne
- [ ] Satisfaction voyageurs

## 🎯 Analyses Suggérées

1. **Heures de pointe** : 6h-9h et 17h-20h
2. **Lignes les plus fréquentées**
3. **Arrêts critiques** avec surcharge
4. **Optimisation des horaires**
5. **Prévision de la demande**

---

**Durée** : 2-3 semaines | **Niveau** : Intermédiaire