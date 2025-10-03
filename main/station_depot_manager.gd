extends Node3D

func _on_area_depot_body_entered(body: Node3D) -> void:
	body.current_station = self
	if body.is_in_group("Agents") :
		body.sprite.texture = null
func on_use() :
	
	pass
