extends Node3D
var inventory:Array = []
func _on_area_depot_body_entered(body: Node3D) -> void:
	body.current_station = self
	if body.is_in_group("Agents") :
		body.sprite.texture = null
		inventory.append(body.held_item)
		body.held_item = null
		body.next_action = null
	if inventory.has("steak cuit") and inventory.has("fromage fondu") and inventory.has("pain toast") and inventory.has("salade essorée") :
		inventory.clear()
		print("Burger envoyé !")
