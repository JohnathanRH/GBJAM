extends Node

@onready var player: Player = get_parent()
@onready var container: BulletsContainer = get_tree().get_first_node_in_group("bullets_container")
var pointer: float = 0:
	set = set_pointer

func _ready() -> void:
	#var button: BulletButton = container.get_child(0)
	player.selected_bullet = container.select(0)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pad_left"):
		pointer -= 1
		player.selected_bullet = container.select(pointer)
	
	if event.is_action_pressed("pad_right"):
		pointer += 1
		player.selected_bullet = container.select(pointer)
	
	if event.is_action_pressed("A"):
		pass

func set_pointer(value: int) -> void:
	#print(pointer, " ", container.get_child_count(), " ", pointer >= container.get_child_count())
	if value < 0 or value >= container.get_child_count():
		print("Warning: Tried to set targeting pointer to an out of bounds value ("+str(pointer)+")")
	else:
		pointer = value
