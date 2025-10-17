extends Node3D

var ingredients = ["salade", "steak", "fromage","pain"]

func _on_area_frigo_body_entered(body: Node3D) -> void:
	if body.is_in_group("Agents") :
		body.get_from_fridge(pop_random(ingredients))

func pop_random(array: Array):
	# Safety check: Can't pop from an empty array.
	if array.is_empty():
		return null
	
	# Get a random index from 0 to array.size() - 1
	var random_index = randi() % array.size()
	
	# Pop the element at that index and return it
	return array.pop_at(random_index)
