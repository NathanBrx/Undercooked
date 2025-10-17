extends Node3D


func _on_area_frigo_body_entered(body: Node3D) -> void:
	if body.is_in_group("Agents") :
		body.recupere_frigo()
