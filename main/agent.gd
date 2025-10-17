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
var order = ['cooked_steak']
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
	if (order.is_empty()):
		pass
	next_ing = order[0]
	
	if (next_ing == 'cooked_steak') and queue_action.is_empty():
		queue_action.insert(0,'cook_'+origin(next_ing))
		queue_action.insert(0,'take_'+origin(next_ing))
		queue_action.append('bing_'+next_ing)
	
	
	if (queue_action[0].substr(0,4) == 'take') :
		move_to('fridge_manager')
	elif (queue_action[0].substr(0,4) == 'cook') :
		move_to('station_steak_manager')

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
		
	pass

func get_from_fridge(ing) :
	
	#effectue une action dépendemment de la station dans laquelle on se trouve et de l'inventaire de l'action 
	pass


func _on_area_frigo_body_entered(body: Node3D) -> void:
	if (body.is_in_group('Agents')):
		
		get_from_fridge(origin(next_ing))
		queue_action.pop_front()
		print(queue_action)
