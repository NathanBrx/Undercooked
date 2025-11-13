extends Node3D
var fromage_ready = false
var salade_ready = false
var steak_ready = false
var pain_ready = false
var recette
var list_agent
var Mat
var Mat_item
var Nat
var Ili
var Art
var etatAgents
signal action_to(agent,dest)


	

var ingredients = ["salade", "steak", "fromage"]

func _ready() -> void:
	if (recette == null):
		recette = generate_recipe()
	list_agent =  get_tree().get_nodes_in_group("Agents")
	Mat = list_agent[0]
	Nat = list_agent[1]
	Ili = list_agent[2]
	Art = list_agent[3]
	etatAgents = { Mat.name: Mat.held_item, Nat.name: Nat.held_item, Ili.name : Ili.held_item, Art.name : Art.held_item}

func generate_recipe():
	var recipe = []
	var nb_ingredient = randi_range(1,5)
	for i in range(nb_ingredient):
		recipe.append(ingredients.pick_random())
	return recipe
	
func _on_area_frigo_body_entered(body: Node3D) -> void:
	if body.is_in_group("Agents") :
		body.get_from_fridge(pop_random(ingredients))
func transforms(ing):
	if (ing == 'steak'):
		return 'station_steak_manager'
func origin(ing):
	if (ing == 'cooked_steak'):
		return 'steak'
		
func get_etat_agent(agent):
	return etatAgents[agent.name]
	
	
func _process(delta: float) -> void:
	Mat_item = get_etat_agent(Mat)
	if (Mat_item == null):
		if (fromage_ready == false and salade_ready == false and steak_ready == false and pain_ready == false):
			action_to.emit(Mat,'fridge_manager')
	
	
		

		


func _on_station_fromage_manager_fromage_ready() -> void:
	
	fromage_ready = true
	print(fromage_ready)
	 # Replace with function body.


func _on_station_cooking_steak_ready() -> void:
	steak_ready = true


func _on_station_salade_manager_salade_ready() -> void:
	salade_ready = true


func _on_station_pain_manager_pain_ready() -> void:
	pain_ready = true

func pop_random(array: Array):
	# Safety check: Can't pop from an empty array.
	if array.is_empty():
		return null
	
	# Get a random index from 0 to array.size() - 1
	var random_index = randi() % array.size()
	
	# Pop the element at that index and return it
	return array.pop_at(random_index)
