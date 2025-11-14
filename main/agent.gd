extends CharacterBody3D
@export var base_collision:Node3D

@onready var sprite = $"MeshInstance3D/Sprite3D"
@onready var base = $"../../station_base_manager/station_base/AreaBase/CollisionBase"
@onready var fridge_collision = $"../../station_frigo_manager/AreaFrigo/CollisionFrigo"
@onready var steak_collision = $"../../station_steak_manager/station_steak/AreaSteak/CollisionSteak"
@onready var salade_collision = $"../../station_salade_manager/station_salade/AreaSalade/CollisionSalade"
@onready var fromage_collision = $"../../station_fromage_manager/station_fromage/AreaFromage/CollisionFromage"
@onready var pain_collision = $"../../station_pain_manager/station_pain/AreaPain/CollisionPain"
@onready var depot_collision = $"../../station_depot_manager/station_depot/AreaDepot/CollisionDepot"

var held_item 
var recette
var next_action
var current_station
var next_ing

func _process(delta: float) -> void:
	#move_to('fridge_manager')
	algo()

func see() :
	#récupère les états des stations, de la commande
	pass
	
func next() :
	#execute la prochaine action dans la file, modifie l'état de l'agent
	pass

func algo():
	#print(held_item,' ',next_action)
	if (next_action == 'gotoFridge'):
		move_to('fridge_manager')
	if (held_item == 'steak' or next_action == 'gotoSteak') :
		move_to('station_steak_manager')
	if (held_item == 'fromage' or next_action == 'gotoFromage'):
		move_to('station_fromage_manager')
	if (held_item == 'salade' or next_action == 'gotoSalade'):
		move_to('station_salade_manager')
	if (held_item == 'pain' or next_action == 'gotoPain'):
		move_to('station_pain_manager')
	if (held_item == 'pain toast' or held_item == 'salade essorée' or held_item == 'steak cuit' or held_item == 'fromage fondu'):
		move_to('station_depot')
	if (next_action == null and held_item == null):
		move_to('base')
	
func move_to(station) :
	var target_map = {
		'station_steak_manager': steak_collision,
		'fridge_manager': fridge_collision,
		'station_fromage_manager': fromage_collision,
		'station_salade_manager': salade_collision,
		'station_pain_manager': pain_collision,
		'station_depot': depot_collision,
		'base': base
	}
	var target = target_map.get(station)
	if (target):
		global_position = global_position.move_toward(target.global_position, 0.1)
	pass

func get_from_fridge(ing) :
	if (held_item == null):
		held_item = ing
	next_action=null

func _on_station_frigo_manager_action_to(agent: Variant, dest: Variant) -> void:
	if (agent==$"."):
		next_action = dest
