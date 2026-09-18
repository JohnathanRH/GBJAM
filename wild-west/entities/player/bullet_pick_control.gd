extends Node

@onready var player: Player = get_parent()
@onready var container: BulletsContainer = get_tree().get_first_node_in_group("bullets_container")
var pointer: float = 0:
	set = set_pointer

func _ready() -> void:
	container.ready.connect(_on_container_ready)

func _on_container_ready() -> void:
	player.selected_bullet = container.select(0)

func _unhandled_input(event: InputEvent) -> void:
	if container.get_child_count() != 0:
		if event.is_action_pressed("pad_left"):
			pointer -= 1
			player.selected_bullet = container.select(pointer)
		
		if event.is_action_pressed("pad_right"):
			pointer += 1
			player.selected_bullet = container.select(pointer)
		
		if event.is_action_pressed("A"):
			for enemy in player.selected_targets:
				player.selected_bullet.manual_fire(enemy)
			container.discard_bullet(container.selected_button.bullet)
			container.remove_child(container.selected_button)
			pointer -= 1
			if container.get_child_count() != 0:
				player.selected_bullet = container.select(pointer)

func set_pointer(value: int) -> void:
	#print(pointer, " ", container.get_child_count(), " ", pointer >= container.get_child_count())
	if value < 0:
		print("Warning: Tried to set targeting pointer to < 0 ("+str(pointer)+")")
		pointer = 0
	elif value >= container.get_child_count():
		print("Warning: Tried to set targeting pointer to >= container cards count ("+str(pointer)+")")
		pointer = container.get_child_count()-1
	else:
		pointer = value
