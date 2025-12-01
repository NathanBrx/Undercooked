extends Node3D

@onready var timer = $"../"

var fromage_ready = false
var salade_ready = false
var steak_ready = false
var pain_ready = false
var recette
var recette_global
var list_agent
var Mat
var Nat
var Ili
var Art
var etatAgents = {}
var actionAgents = {}
var AgentEndormi = []
signal action_to(agent,dest)




var ingredients = ["salade", "steak", "fromage"]

func _ready() -> void:
	print(recette)
	if (recette == null or recette == []):
		recette = generate_recipe()
	print(recette)
	list_agent =  get_tree().get_nodes_in_group("Agents")
	Mat = list_agent[0]
	Nat = list_agent[1]
	Ili = list_agent[2]
	Art = list_agent[3]
	etatAgents[Mat] = Mat.held_item
	actionAgents[Mat] = Mat.next_action
	etatAgents[Nat] = Nat.held_item
	actionAgents[Nat] = Nat.next_action
	etatAgents[Ili] = Ili.held_item
	actionAgents[Ili] = Ili.next_action
	etatAgents[Art] = Art.held_item
	actionAgents[Art] = Art.next_action

func generate_recipe():
	timer.timer.start()
	var recipe = []
	var ingredient_recipe = ingredients.duplicate()
	var nb_ingredient = randi_range(1,3)
	for i in range(nb_ingredient):
		recipe.append(pop_random(ingredient_recipe))
	recipe.append("pain")
	print("nouvelle recette : ",recipe)
	recette_global = recipe.duplicate()
	return recipe
	
func _on_area_frigo_body_entered(body: Node3D) -> void:
	if body.is_in_group("Agents") :
		body.get_from_fridge(pop_random(recette))
		
func transforms(ing):
	if (ing == 'steak'):
		return 'station_steak_manager'

func origin(ing):
	if (ing == 'cooked_steak'):
		return 'steak'
		
func get_etat_agent():
	for i in list_agent :
		if (etatAgents[i] != i.held_item):
			etatAgents[i] = i.held_item
		if (actionAgents[i] != i.next_action) :
			actionAgents[i] = i.next_action
	var pr = ""
	for i in actionAgents :
		if (actionAgents[i] != null):
			pr += ' ; '+str(i)+' : '+str(actionAgents[i])

func set_agent_endormi():
	AgentEndormi = []
	for k in etatAgents :
		if (k.next_action == null and k.held_item == null):	
			AgentEndormi.append(k)

func _process(delta: float) -> void:
	set_agent_endormi()
	get_etat_agent()
	if (fromage_ready && (!AgentEndormi.is_empty())):
		get_etat_agent()
		var agent_actif = AgentEndormi.pick_random()
		fromage_ready = false
		set_agent_endormi()
		action_to.emit(agent_actif,'gotoFromage')
	elif (salade_ready && (!AgentEndormi.is_empty())):
		get_etat_agent()
		var agent_actif = AgentEndormi.pick_random()
		salade_ready = false
		set_agent_endormi()
		action_to.emit(agent_actif,'gotoSalade')
	elif (steak_ready && (!AgentEndormi.is_empty())):
		get_etat_agent()
		var agent_actif = AgentEndormi.pick_random()
		steak_ready = false
		set_agent_endormi()
		action_to.emit(agent_actif,'gotoSteak')
	elif (pain_ready && (!AgentEndormi.is_empty())):
		get_etat_agent()
		var agent_actif = AgentEndormi.pick_random()
		pain_ready = false
		set_agent_endormi()
		action_to.emit(agent_actif,'gotoPain')
	elif (!recette.is_empty()):
		set_agent_endormi()
		var agent_actif
		if (!AgentEndormi.is_empty()):
			agent_actif = AgentEndormi.pick_random()
		else :
			agent_actif = null
		if (agent_actif != null):
			if (agent_actif.held_item == null):
				agent_actif.next_action = 'gotoFridge'
				set_agent_endormi()
				action_to.emit(agent_actif,'gotoFridge')

func _on_station_fromage_manager_fromage_ready() -> void:
	
	fromage_ready = true

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


func _on_station_steak_manager_steak_ready() -> void:
	steak_ready = true
