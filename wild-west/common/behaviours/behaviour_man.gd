extends Node
class_name BehaviourMan

@export var initBehaviour : Behaviour
var currentBehaviour : Behaviour
var behaviours := {} as Dictionary

signal BehaviourEntered(behaviour: Behaviour)
signal BehaviourExited(behaviour: Behaviour)

func add_new_behaviour(behaviour : Behaviour) -> void:
	add_child(behaviour)
	behaviours[behaviour.name.to_lower()] = behaviour
	behaviour.ChangeBehaviour.connect(_on_change_behaviour)

func _ready():
	for child in get_children():
		if child is Behaviour:
			behaviours[child.name.to_lower()] = child
			child.ChangeBehaviour.connect(_on_change_behaviour)
			child.Setup()
	if initBehaviour:
		currentBehaviour = initBehaviour
		currentBehaviour.Enter()

func _enter_tree() -> void:
	if currentBehaviour:
		currentBehaviour.Preload()

func _process(delta):
	if currentBehaviour:
		currentBehaviour.Update(delta)

func _physics_process(delta):
	if currentBehaviour:
		currentBehaviour.Update_Physics(delta)

func _unhandled_input(event: InputEvent) -> void:
	if currentBehaviour:
		currentBehaviour.Unhandled_Input(event)

func _on_change_behaviour(behaviour : Behaviour, newBehaviourKey : String):
	if (behaviour != currentBehaviour):
		print("Debug: behaviour must be equal to currentBehaviour in order to switch")
		print("The behaviour in the param is "+behaviour.name+"\n"+"While the currentBehaviour is "+currentBehaviour.name)
	
	var newBehaviour = behaviours[newBehaviourKey.to_lower()] as Behaviour
	if !newBehaviour:
		print("Debug: behaviour "+newBehaviourKey+" does not exist")
		return
	
	if currentBehaviour:
		#print("exiting")
		currentBehaviour.Exit()
		BehaviourExited.emit(currentBehaviour)
	newBehaviour.Enter()
	BehaviourEntered.emit(newBehaviour)
	currentBehaviour = newBehaviour
