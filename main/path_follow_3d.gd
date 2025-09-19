extends PathFollow3D

var checkpoints := [0.0, 0.19, 0.35, 0.61, 0.81]  # positions sur le path (0 à 1)
var current_checkpoint := 0
var frames = [
	null,
	preload("res://ressources/burger/1.png"),
	preload("res://ressources/burger/2.png"),
	preload("res://ressources/burger/3.png"),
	preload("res://ressources/burger/4.png")
]
@export var sprite:Sprite3D
func _process(delta):
	# avancer le PathFollow3D
	progress_ratio += 0.005  # exemple
	if progress_ratio > 1.0:
		progress_ratio = 1.0

	# vérifier si on a passé le prochain checkpoint
	if current_checkpoint < checkpoints.size() and progress_ratio >= checkpoints[current_checkpoint]:
		print("Checkpoint atteint :", current_checkpoint)
		_on_checkpoint(current_checkpoint)
		current_checkpoint += 1
		
func _on_checkpoint(index):
	# Exemple : changer la frame du sprite ou ramasser un ingrédient
	if sprite != null and frames.size() > 0:
		if index == 0 :
			sprite.texture = null
		else :
			sprite.texture = frames[index]
	print("Action pour station", index)
