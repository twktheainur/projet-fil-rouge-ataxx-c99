# Projet Fil Rouge - IA de jeu Ataxx en C99

Projet pedagogique en C99 autour d'un environnement de jeu de type Ataxx.
Le depot contient un moteur minimal, une interface de test, une AVL de reference,
et l'infrastructure necessaire pour developper et evaluer un agent base sur minimax
et l'elagage alpha-beta.

## Contenu

- `src/` : moteur, chargeur d'agents, TUI et agents fournis
- `include/` : interfaces publiques
- `tests/` : tests unitaires simples
- `docs/` : sujet, protocole et guide des plugins
- `tools/` : scripts utilitaires

## Compilation

Sous Windows ou Linux, depuis le dossier `project/` :

```sh
make
```

Cibles utiles :

- `make ataxx_cli`
- `make ataxx_harness`
- `make test_avl`
- `make test_tui`
- `make student_plugin SRC=my_agent.c NAME=custom`

Le depot ne fournit plus d'agent etudiant integre. Les strategies etudiantes
sont attendues sous forme de plugins construits avec `student_plugin`.

## Objectif pedagogique

Le travail attendu porte principalement sur :

- une fonction d'evaluation argumentee
- un minimax a profondeur bornee
- un alpha-beta correct
- l'integration d'une structure equilibree
- une evaluation experimentale et une analyse de complexite

Le detail du sujet est disponible dans `docs/project_subject.md`.