extends HBoxContainer
class_name BulletsContainer

var button_scn = preload("res://props/bullet_button/bullet_button.tscn")
@onready var player: Player = get_tree().get_first_node_in_group("player")
var selected_button: BulletButton

func _ready() -> void:
	for bullet in player.bullets:
		var button: BulletButton = button_scn.instantiate()
		button.bullet = bullet
		button.set_icon(bullet.icon)
		add_child(button)

func select(index: int) -> BulletResource:
	if selected_button:
		selected_button.unselected()
	
	selected_button = get_child(index)
	selected_button.selected()
	#print(selected_button.bullet)
	return selected_button.bullet
