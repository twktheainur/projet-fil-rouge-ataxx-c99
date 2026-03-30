# Projet Fil Rouge - IA de jeu en C99

## Objectif

Concevoir un agent de jeu en C99 pour un environnement de type Ataxx.
Le moteur de jeu, l'arbitre et une baseline sont fournis. Votre travail porte sur l'agent et sur l'analyse de ses performances.

## Contraintes pédagogiques

- langage: C99
- recherche: minimax avec profondeur bornée
- amélioration: élagage alpha-beta
- structure avancée obligatoire: AVL ou justification d'une autre structure auto-équilibrée
- rendu: archive de code + rapport PDF

## Ce qui est fourni

- représentation d'état
- génération et application des coups
- impression console pour débogage
- AVL de référence minimale
- agent baseline très simple

## Ce qui est attendu

1. Une fonction d'évaluation argumentée.
2. Un minimax profondeur bornée.
3. Un alpha-beta correct.
4. Une intégration justifiée de la structure équilibrée.
5. Une campagne de test contre plusieurs adversaires.
6. Une analyse de complexité théorique et observée.

## Jalons recommandés

1. Semaine 1: compilation, lecture du code fourni, premier agent légal.
2. Semaine 2: AVL comprise, testée et instrumentée.
3. Semaine 3: minimax profondeur 2 ou 3.
4. Semaine 4: alpha-beta et ordre des coups.
5. Semaine 5: évaluation expérimentale et finalisation du rapport.