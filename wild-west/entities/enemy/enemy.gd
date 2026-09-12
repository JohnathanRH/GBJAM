extends Entity
class_name Enemy

@onready var player = get_tree().get_first_node_in_group("player") as Player

func _ready() -> void:
	super._ready()
	select_random_bullet()

func fire_bullet() -> void:
	if selected_bullet:
		print("Enemy fired "+ selected_bullet.resource_name)
		selected_bullet.fire(player)
	select_random_bullet()

func select_random_bullet() -> void:
	selected_bullet = bullets.pick_random()
	print(selected_bullet)
