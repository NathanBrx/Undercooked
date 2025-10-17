extends CharacterBody3D
@export var sprite:Sprite3D
var held_item:String
var recette
var next_action
var current_station
func see() :
	#récupère les états des stations, de la commande
	pass
	
func next() :
	#execute la prochaine action dans la file, modifie l'état de l'agent
	pass
	
func move_to(station) :
 #déplace le personnage vers la station correspondante
	pass

func use_station() :
	
	current_station.on_use()
	#effectue une action dépendemment de la station dans laquelle on se trouve et de l'inventaire de l'action 
	pass


func _on_area_depot_body_entered(body: Node3D) -> void:
	pass # Replace with function body.
