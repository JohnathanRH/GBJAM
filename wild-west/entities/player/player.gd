extends Entity
class_name Player

@onready var enemy: Entity = get_tree().get_first_node_in_group("enemies") as Enemy

func fire_bullet() -> void:
	if selected_bullet:
		selected_bullet.fire(enemy)

#func _on_bullet_ph_timer_timeout() -> void:
	#$BulletPlaceholder.visible = false
