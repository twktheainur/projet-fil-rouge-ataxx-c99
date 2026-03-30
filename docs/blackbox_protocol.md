# Protocole Du Bot Noir

Le bot noir est pensé comme une référence de test et de calibration. Le moteur fourni reste l'autorité sur les règles.

## Format recommandé

Le protocole le plus simple à déployer en TP est un protocole texte via `stdin` et `stdout`.

### Messages moteur vers agent

- `INIT player=<1|2> size=5`
- `STATE turn=<n> current=<1|2> board=<25 caractères>`
- `MOVE_TIMEOUT ms=<budget>`
- `STOP`

Le plateau est sérialisé ligne par ligne avec les symboles `X`, `O` et `.`.

### Messages agent vers moteur

- `MOVE r1 c1 r2 c2`
- `PASS`

## Règles d'intégration

1. Un agent ne doit écrire qu'une seule ligne de réponse par tour.
2. Toute sortie de débogage doit être redirigée vers `stderr`.
3. Un agent dépassant le budget temps perd la partie.
4. Une réponse invalide entraîne une défaite immédiate.

## Usage enseignant

Le bot noir est fourni sous la même interface afin que les groupes puissent se tester localement sans connaître son implémentation interne.