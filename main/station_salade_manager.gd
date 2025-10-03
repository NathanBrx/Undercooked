extends Node3D

func _on_area_salade_body_entered(body: Node3D) -> void:
	
	if body.is_in_group("Agents") :
		body.sprite.texture = load("res://ressources/burger/3.png")
