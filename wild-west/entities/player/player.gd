extends Entity
class_name Player

@export var bullets: Array[BulletResource]
@export var bullet_container: BulletsContainer

var selected_bullet: BulletResource:
	set = set_selected_bullet
var selected_targets: Array[Enemy]

signal bullet_selected
#signal target_selected

#func _ready() -> void:
	#super._ready()
	#selected_bullet = bullets[0]

func fire_bullet() -> void:
	for bullet_btn: BulletButton in bullet_container.get_children():
		for target in selected_targets:
			bullet_btn.bullet.fire(target)
	

func set_selected_bullet(bullet: BulletResource) -> void:
	selected_bullet = bullet
	bullet_selected.emit()

func death() -> void:
	pass

func manual_fire() -> void:
	pass
