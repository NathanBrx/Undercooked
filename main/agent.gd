extends CharacterBody3D
@export var sprite:Sprite3D
@export var steak_colision:Node3D
@export var salade_colision:Node3D
@export var fromage_colision:Node3D
@export var pain_colision:Node3D
@export var depot_colision:Node3D
@export var fridge_colision:Node3D
var held_item
var recette
var next_action
var current_station
var queue_action = []
var next_ing
var steak_station_position = Vector3(0, 0, 0)

func _process(delta: float) -> void:
	algo()

func transforms(ing):
	if (ing == 'steak'):
		return 'station_steak_manager'
func origin(ing):

	if (ing == 'cooked_steak'):
	
		return 'steak'

func algo():
	if (queue_action.is_empty()):
		move_to('fridge_manager')
	if (held_item == 'steak') :
		move_to('station_steak_manager')
	if (held_item == 'fromage'):
		move_to('station_fromage_manager')
	if (held_item == 'salade'):
		move_to('station_salade_manager')
	if (held_item == 'pain'):
		move_to('station_pain_manager')
	if (held_item == 'pain toast' or held_item == 'salade essorée' or held_item == 'steak cuit' or held_item == 'fromage fondu'):
		move_to('station_depot')

func see() :
	#récupère les états des stations, de la commande
	pass
	
func next() :
	#execute la prochaine action dans la file, modifie l'état de l'agent
	pass
	
func move_to(station) :
	
 #déplace le personnage vers la station correspondante
	if (station == 'station_steak_manager'):
		if steak_colision :
			global_position = global_position.move_toward(steak_colision.global_position,0.1)
	elif (station == 'fridge_manager'):
		if fridge_colision :
			global_position = global_position.move_toward(fridge_colision.global_position,0.1)
	elif (station == 'station_fromage_manager'):
		if fromage_colision :
			global_position = global_position.move_toward(fromage_colision.global_position,0.1)
	elif (station == 'station_salade_manager'):
		if salade_colision :
			global_position = global_position.move_toward(salade_colision.global_position,0.1)
	elif (station == 'station_fromage_manager'):
		if pain_colision :
			global_position = global_position.move_toward(pain_colision.global_position,0.1)
	elif (station == 'station_depot'):
		if depot_colision :
			global_position = global_position.move_toward(depot_colision.global_position,0.1)
	pass

func get_from_fridge(ing) :
	
	#effectue une action dépendemment de la station dans laquelle on se trouve et de l'inventaire de l'action 
	pass


func _on_area_frigo_body_entered(body: Node3D) -> void:
	if (body.is_in_group('Agents')):
		
		get_from_fridge(origin(next_ing))
		queue_action.pop_front()
		print(queue_action)
