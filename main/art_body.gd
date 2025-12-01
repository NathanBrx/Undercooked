extends CharacterBody3D
@export var sprite:Sprite3D
@export var steak_collision:Node3D
@export var salade_collision:Node3D
@export var fromage_collision:Node3D
@export var pain_collision:Node3D
@export var depot_collision:Node3D
@export var fridge_collision:Node3D
@export var base_collision:Node3D

@onready var base = $"../../station_base_manager/station_base/AreaBase/CollisionBase"

var held_item 
var recette
var next_action
var current_station
var next_ing


func _process(delta: float) -> void:
	algo()


func see() :
	#récupère les états des stations, de la commande
	pass
	
func next() :
	#execute la prochaine action dans la file, modifie l'état de l'agent
	pass

func algo():
	if (next_action == 'gotoFridge'):
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
	if (next_action == null):
			move_to('base')
	
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
	elif (station == 'base') :
		if base :
			global_position = global_position.move_toward(base.global_position,0.1)
	pass

func get_from_fridge(ing) :
	if (held_item == null):
		held_item = ing
	next_action==null


func _on_station_frigo_manager_action_to(agent: Variant, dest: Variant) -> void:
	print(agent)
	if (agent==$"."):
		move_to(dest) # Replace with function body.
