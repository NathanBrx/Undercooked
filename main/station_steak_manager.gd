extends Node3D
var cook_timer:Timer

func _on_area_steak_body_entered(body: Node3D) -> void:
	
	if body.is_in_group("Agents") :
 
		body.sprite.texture = load("res://ressources/burger/2.png")
