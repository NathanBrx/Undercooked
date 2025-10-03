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
	path_follow.progress_ratio += 0.005  # exemple
	if path_follow.progress_ratio > 1.0:
		path_follow.progress_ratio = 1.0
