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
var Nat_item
var Ili
var Ili_item
var Art
var Art_item
var etatAgents = {}
var actionAgents = {}
var AgentEndormi = []
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
	etatAgents[Mat] = Mat.held_item
	actionAgents[Mat] = Mat.next_action
	etatAgents[Nat] = Nat.held_item
	actionAgents[Nat] = Nat.next_action
	etatAgents[Ili] = Ili.held_item
	actionAgents[Ili] = Ili.next_action
	etatAgents[Art] = Art.held_item
	actionAgents[Art] = Art.next_action

func generate_recipe():
	var recipe = []
	var test_recipe = ['fromage','steak','salade','pain']
	var nb_ingredient = randi_range(1,5)
	for i in range(nb_ingredient):
		recipe.append(ingredients.pick_random())
	recipe.append("pain")
	return test_recipe
	
func _on_area_frigo_body_entered(body: Node3D) -> void:
	if body.is_in_group("Agents") :
		body.get_from_fridge(pop_random(recette))
		
func transforms(ing):
	if (ing == 'steak'):
		return 'station_steak_manager'

func origin(ing):
	if (ing == 'cooked_steak'):
		return 'steak'
		
func get_etat_agent(agent):
	if (etatAgents[agent] != agent.held_item):
		etatAgents[agent] = agent.held_item
	if (actionAgents[agent] != agent.next_action) :
		actionAgents[agent] = agent.next_action
	print(agent, ' : ',etatAgents[agent])
	return etatAgents[agent]
	
func set_agent_endormi():
	AgentEndormi = []
	for k in etatAgents :
		if (k.next_action == null and k.held_item == null):	
			AgentEndormi.append(k)

func _process(delta: float) -> void:
	set_agent_endormi()
	if (fromage_ready && (!AgentEndormi.is_empty())):
		var agent_actif = AgentEndormi.pick_random()
		print('agent :',agent_actif)
		fromage_ready = false
		set_agent_endormi()
		action_to.emit(agent_actif,'gotoFromage')
	if (salade_ready && (!AgentEndormi.is_empty())):
		var agent_actif = AgentEndormi.pick_random()
		print('agent :',agent_actif)
		salade_ready = false
		set_agent_endormi()
		action_to.emit(agent_actif,'gotoSalade')
	if (steak_ready && (!AgentEndormi.is_empty())):
		var agent_actif = AgentEndormi.pick_random()
		print('agent :',agent_actif)
		steak_ready = false
		set_agent_endormi()
		action_to.emit(agent_actif,'gotoSteak')
	if (pain_ready && (!AgentEndormi.is_empty())):
		var agent_actif = AgentEndormi.pick_random()
		print('agent :',agent_actif)
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
				print(agent_actif,' : ',agent_actif.next_action,' & ', agent_actif.held_item)
				action_to.emit(agent_actif,'gotoFridge')



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


func _on_station_steak_manager_steak_ready() -> void:
	pass # Replace with function body.
