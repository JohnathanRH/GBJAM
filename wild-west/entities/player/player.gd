extends Entity
class_name Player

var selected_targets: Array[Enemy]

func _ready() -> void:
	super._ready()
	selected_bullet = bullets[0]

func fire_bullet() -> void:
	for enemy in selected_targets:
		print(enemy.vulnerable)
		if selected_bullet and enemy.vulnerable:
			selected_bullet.fire(enemy)
			print("Firing at: ", enemy)
	

func death() -> void:
	pass

func manual_fire() -> void:
	pass
