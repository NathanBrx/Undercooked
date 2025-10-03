extends Node3D
func _on_area_pain_body_entered(body: Node3D) -> void:
	if body.is_in_group("Agents") :
		body.sprite.texture = load("res://ressources/burger/1.png")
