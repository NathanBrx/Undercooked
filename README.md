# POA/SMA HAI716I : Projet Overcooked

Simulation d'un environnement avec un agent cuisinier autonome inspirée d'Overcooked, réalisée avec Godot Engine et le langage GDScript dans le cadre de l'UE POA/SMA (HAI716I).

---

## Fonctionnalités

* **Environnement 3D :** Un monde simple contenant un sol, un éclairage et des stations de cuisine interactives.
* **Stations Interactives :** 6 stations au total (Frigo, Fromage, Steak, Salade, Pain, Dépôt) qui détectent l'agent lorsqu'il entre dans leur zone (`Area3D`).
* **Préparation Asynchrone :** Les stations de préparation (pain, steak, etc.) ne donnent pas l'ingrédient instantanément. Elles démarrent un `Timer` avec un **temps de préparation aléatoire**.
* **Agent Autonome :** Un "cuisinier" (`agent.gd`) qui n'est pas scripté pour suivre un chemin. Il prend ses propres décisions pour accomplir ses tâches.
  
---

## Comment fonctionne l'agent

C'est un **agent à état** : il a une "mémoire" (son état interne) et un but (la recette). Il décide quoi faire en suivant une boucle de décision.

### 1. État Interne (Sa "Mémoire")

L'agent utilise ces variables pour savoir ce qu'il se passe :
* `held_item` : L'ingrédient qu'il tient actuellement.
* `fromage_ready`, `salade_ready`, etc.: Des booléens qui stockent sa perception de l'environnement (ex: "est-ce que le fromage est prêt ?").

L'agent utilise ces variables pour savoir ce qu'il se passe :
* `held_item`: L'ingrédient qu'il tient actuellement (ex: "steak", "steak cuit"). **C'est l'indicateur d'état principal.**


### 2. Boucle de Décision (Son "Cerveau" : `algo()`)

La logique de l'agent est gérée par la fonction `algo()`, appelée à chaque image. Elle fonctionne comme une machine à états :

* **État 1 : Si `held_item` est `null` (mains vides)** 
    * L'agent vérifie ses variables de perception (ex: `fromage_ready`).
    * Si un ingrédient est prêt sur une station, il appelle `move_to()` pour aller le chercher.
    * Sinon, il appelle `move_to('fridge_manager')` pour prendre un nouvel ingrédient de base au frigo.

* **État 2 : Si `held_item` est un ingrédient brut (ex: "steak")** 
    * L'agent appelle `move_to('station_steak_manager')` pour aller déposer l'ingrédient à la station de préparation.

* **État 3 : Si `held_item` est un ingrédient cuit (ex: "steak cuit")**
    * L'agent appelle `move_to('station_depot')` pour aller livrer le produit fini.
 
### 3. Perception (via Signaux)

L'agent n'observe pas activement l'environnement (sa fonction `see()` est vide). C'est l'environnement (les stations) qui **notifie** l'agent :

1.  Une station (ex: `station_fromage_manager`) termine sa préparation (`Timer`).
2.  Elle émet un signal : `fromage_ready.emit()`.
3.  L'agent, qui est connecté à ce signal, reçoit l'info et exécute `_on_station_fromage_manager_fromage_ready()`.
4.  Cette fonction met à jour son état de perception : `fromage_ready = true`.
5.  Au prochain appel de `algo()`, l'agent verra que le fromage est prêt et décidera d'aller le chercher.

### 4. Mouvement (Fonction `move_to`)

Le déplacement est autonome mais simple. La fonction `move_to(station)` n'utilise **pas** de pathfinding (comme `NavigationServer`).
Elle utilise `global_position.move_toward()` pour déplacer l'agent en ligne droite vers la position de la station cible, qu'il connaît grâce à une variable exportée (ex: `steak_colision`).

