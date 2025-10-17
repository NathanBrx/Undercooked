extends Node3D

var ingredient_ready: bool = false
var preping_bool: bool = false
var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var timer: Timer = Timer.new()
var ingredient = "salade"
var cooked_ingredient = "salade essorée"
# --- Initialisation ---
func _ready():
	# 1. Ajouter le Timer à l'arborescence pour qu'il fonctionne
	add_child(timer)
	
	# 2. Rendre le Timer 'one-shot' (il ne s'exécute qu'une fois)
	timer.one_shot = true
	
	# 3. Connecter le signal timeout à la fonction de fi
	timer.timeout.connect(_on_preping_timer_timeout)

# --- Logique de l'Aire d'Interaction ---
func _on_area_pain_body_entered(body: Node3D) -> void:
	if body.is_in_group("Agents") and not preping_bool and body.held_item == ingredient:
		body.held_item == null
		preping() # Démarre le processus de préparation
	elif body.is_in_group("Agents") and ingredient_ready and body.held_item == null:
		body.sprite.texture = load("res://ressources/burger/3.png")
		body.held_item = cooked_ingredient
		ingredient_ready = false

# --- Logique de Préparation (Lancement du Timer Aléatoire) ---
func preping() -> void:
	preping_bool = true
	
	# Définir une plage aléatoire, par exemple entre 2.0 et 5.0 secondes
	var temps_attente_aleatoire: float = rng.randf_range(4.0, 15.0) 
	
	print("Préparation démarrée. Temps d'attente : ", temps_attente_aleatoire, "s.")
	
	# Configurer le temps du Timer
	timer.wait_time = temps_attente_aleatoire
	
	# Lancer le Timer
	timer.start()

# --- Fonction Exécutée à la Fin du Timer ---
func _on_preping_timer_timeout() -> void:
	print("Ingrédient prêt !")
	
	# Mettre à jour les booléens d'état
	ingredient_ready = true
	preping_bool = false
	
	# Mettez ici le code pour changer le sprite, notifier l'agent, etc.
