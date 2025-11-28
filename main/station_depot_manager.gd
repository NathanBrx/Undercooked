extends Node3D
var inventory:Array = []
@onready var frigo = $"../station_frigo_manager"
var recette
	

		
func transform(ing):
	if (ing == 'steak') :
		return 'steak cuit'
	elif (ing == 'salade') :
		return 'salade essorée'
	elif (ing == 'fromage') :
		return 'fromage fondu'
	elif (ing == 'pain') :
		return 'pain toast'
	else :
		return ing
func _on_area_depot_body_entered(body: Node3D) -> void:
	recette = frigo.recette_global
	recette.sort()
	for i in range(len(recette)) : 
		recette[i] = transform(recette[i])
	body.current_station = self
	if body.is_in_group("Agents") :
		body.sprite.texture = null
		inventory.append(body.held_item)
		body.held_item = null
		body.next_action = null
	
	inventory.sort()
	if (inventory == recette) :
		inventory.clear()
		print("Burger envoyé !\n\n")
		recette.clear()
		frigo.recette = frigo.generate_recipe()
