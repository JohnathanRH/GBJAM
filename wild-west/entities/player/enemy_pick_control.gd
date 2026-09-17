extends Node

@onready var player: Player = get_parent()
@onready var enemies: Array[Enemy]
@onready var pointer: int = floori(enemies.size()/2):
	set = set_pointer

func _ready() -> void:
	player.bullet_selected.connect(target_enemies)
	enemies.assign(get_tree().get_nodes_in_group("enemies"))

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pad_up"):
		pointer += 1
		#untarget_enemies()
		target_enemies()
	
	if event.is_action_pressed("pad_down"):
		pointer -= 1
		#untarget_enemies()
		target_enemies()
	

func target_enemies() -> void:
	untarget_enemies()
	var amount = player.selected_bullet.target_amount
	var arr: Array[Enemy]
	for i in amount:
		#print("A")
		if i == 0:
			enemies[pointer].targeted.emit(true)
			arr.push_back(enemies[pointer])
		else:
			var chooser
			if i % 2 == 0:
				chooser = pointer + i
			else:
				chooser = pointer - i
			if chooser < 0 or chooser > enemies.size():
				continue
			else:
				enemies[chooser].targeted.emit(true)
				arr.push_back(enemies[chooser])
	print(arr)
	player.selected_targets = arr

func untarget_enemies() -> void:
	#print(player.selected_targets)
	for enemy in player.selected_targets:
		enemy.targeted.emit(false)

func set_pointer(value: int) -> void:
	if value < 0 or value >= enemies.size():
		print("Warning: Tried to set targeting pointer to an out of bounds value")
	else:
		pointer = value
