extends Entity
class_name Player

var bullets: Array[BulletResource]
@export var bullet_container: BulletsContainer

var selected_bullet: BulletResource:
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
	

func set_selected_bullet(bullet: BulletResource) -> void:
	selected_bullet = bullet
	bullet_selected.emit()

func death() -> void:
	pass

func manual_fire() -> void:
	pass

func mirror_entity_resource() -> void:
	super.mirror_entity_resource()
	bullets = entity_resource.bullets
