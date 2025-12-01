extends Node3D

@export var stations:Array[Node3D]
@export var character:CharacterBody3D
@export var path_follow:PathFollow3D
@export var sprite:Sprite3D
var nameSprite = ""
var timer: Timer = Timer.new()
var frames = [
	null,
	preload("res://ressources/burger/1.png"),
	preload("res://ressources/burger/2.png"),
	preload("res://ressources/burger/3.png"),
	preload("res://ressources/burger/4.png")
]
func _ready() -> void:
	
	# 1. Ajouter le Timer à l'arborescence pour qu'il fonctionne
	add_child(timer)
	
	# 2. Rendre le Timer 'one-shot' (il ne s'exécute qu'une fois)
	timer.one_shot = true
	timer.set_wait_time(30) 
	# 3. Connecter le signal timeout à la fonction de fi
	timer.start()
func _process(delta):
	pass
	#print(30-timer.time_left)


func _on_area_steak_body_entered(body: Node3D) -> void:
	pass # Replace with function body.
