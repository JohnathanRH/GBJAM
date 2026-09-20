extends HBoxContainer
class_name BulletsContainer

@export var hand_count: int = 4
@onready var player: Player = get_tree().get_first_node_in_group("player")

var button_scn = preload("res://props/bullet_button/bullet_button.tscn")
var selected_button: BulletButton
var draw_pile: Array[Bullet]
var discard_pile: Array[Bullet]

func _ready() -> void:
	#player.ready.connect(_on_player_ready)
	draw_pile = player.bullets
	player.damage_received.connect(draw_hand)
	draw_hand()

func select(index: int) -> Bullet:
	if selected_button:
		selected_button.unselected()
	
	selected_button = get_child(index)
	selected_button.selected()
	#print(selected_button)
	return selected_button.bullet

func draw_hand() -> void:
	#if total_redraw:
		#for child in get_children():
			#discard_bullet(child.bullet)
			#remove_child(child)
	var amount = hand_count - get_child_count()
	if draw_pile.size() <= hand_count:
		draw_pile.append_array(discard_pile)
		discard_pile.clear()
	
	for i in amount:
		if draw_pile.is_empty():
			break
		var button: BulletButton = button_scn.instantiate()
		var random_i = randi_range(0, draw_pile.size()-1)
		var bullet: Bullet = draw_pile[random_i]
		draw_pile.pop_at(random_i)
		
		button.bullet = bullet
		button.set_icon(bullet.icon)
		add_child(button)

func discard_bullet(bullet: Bullet):
	discard_pile.push_back(bullet)
