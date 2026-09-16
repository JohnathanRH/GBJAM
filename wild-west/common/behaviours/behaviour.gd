extends Node
class_name Behaviour

@onready var manager := self.get_parent() as BehaviourMan

signal ChangeBehaviour

func Setup() -> void:
	pass

func Preload() -> void:
	pass

func Enter() -> void:
	pass

func Update(delta : float) -> void:
	pass

func Update_Physics(delta : float) -> void:
	pass

func Unhandled_Input(event: InputEvent) -> void:
	pass

func On_Next_Frame() -> void:
	pass

func Exit() -> void:
	pass
