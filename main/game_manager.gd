extends Node3D

@export var stations:Array[Node3D]
@export var character:CharacterBody3D
@export var path_follow:PathFollow3D
@export var sprite:Sprite3D
var nameSprite = ""
var frames = [
	null,
	preload("res://ressources/burger/1.png"),
	preload("res://ressources/burger/2.png"),
	preload("res://ressources/burger/3.png"),
	preload("res://ressources/burger/4.png")
]


func _process(delta):
	# avancer le PathFollow3D
	pass


func _on_area_steak_body_entered(body: Node3D) -> void:
	pass # Replace with function body.
