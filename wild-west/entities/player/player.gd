extends Entity
class_name Player

@export var bullet_container: BulletsContainer

var bullets: Array[Bullet]
var selected_bullet: Bullet:
	set = set_selected_bullet
var selected_targets: Array[Enemy]

signal bullet_selected
signal auto_fired
#signal target_selected

func fire_bullet() -> void:
	for bullet_btn: BulletButton in bullet_container.get_children():
		selected_bullet = bullet_btn.bullet
		for target in selected_targets:
			selected_bullet.fire(target)
		bullet_container.discard_bullet(bullet_btn.bullet)
		bullet_container.remove_child(bullet_btn)
	bullet_container.draw_hand()
	auto_fired.emit()
	

func set_selected_bullet(bullet: Bullet) -> void:
	selected_bullet = bullet
	bullet_selected.emit()

func death() -> void:
	get_tree().change_scene_to_file("res://screens/death_screen/death_screen.tscn")

func manual_fire() -> void:
	pass

func mirror_entity_resource() -> void:
	super.mirror_entity_resource()
	hp = max_hp
	for bullet_scn: PackedScene in entity_resource.bullets:
		var bullet: Bullet = bullet_scn.instantiate()
		bullets.push_back(bullet)
		$Bullets.add_child(bullet)
