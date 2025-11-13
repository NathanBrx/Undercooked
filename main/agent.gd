extends CharacterBody3D
@export var sprite:Sprite3D
@export var steak_collision:Node3D
@export var salade_collision:Node3D
@export var fromage_collision:Node3D
@export var pain_collision:Node3D
@export var depot_collision:Node3D
@export var fridge_collision:Node3D

var held_item 
var recette
var next_action
var current_station
var queue_action = []
var next_ing
var steak_station_position = Vector3(0, 0, 0)


func transforms(ing):
	if (ing == 'steak'):
		return 'station_steak_manager'
func origin(ing):

	if (ing == 'cooked_steak'):
	
		return 'steak'

func see() :
	#récupère les états des stations, de la commande
	pass
	
func next() :
	#execute la prochaine action dans la file, modifie l'état de l'agent
	pass
	
func move_to(station) :
	
 #déplace le personnage vers la station correspondante
	if (station == 'station_steak_manager'):
		if steak_collision :
			global_position = global_position.move_toward(steak_collision.global_position,0.1)
	elif (station == 'fridge_manager'):
		if fridge_collision :
			global_position = global_position.move_toward(fridge_collision.global_position,0.1)
	elif (station == 'station_fromage_manager'):
		if fromage_collision :
			global_position = global_position.move_toward(fromage_collision.global_position,0.1)
	elif (station == 'station_salade_manager'):
		if salade_collision :
			global_position = global_position.move_toward(salade_collision.global_position,0.1)
	elif (station == 'station_pain_manager'):
		if pain_collision :
			global_position = global_position.move_toward(pain_collision.global_position,0.1)
	elif (station == 'station_depot'):
		if depot_collision :
			global_position = global_position.move_toward(depot_collision.global_position,0.1)
	pass

func get_from_fridge(ing) :
	if (held_item == null):
		held_item = ing
	else :
	#effectue une action dépendemment de la station dans laquelle on se trouve et de l'inventaire de l'action 
		pass


func _on_station_frigo_manager_action_to(agent: Variant, dest: Variant) -> void:
	move_to(dest) # Replace with function body.
