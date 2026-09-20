extends Node2D

var enemy_scn = preload("res://entities/enemy/enemy.tscn")

func _enter_tree() -> void:
	$Player.entity_resource = SaveManager.file.player_resource
	
	var stage = SaveManager.file.stage
	for i in stage.enemies.size():
		var enemy: Enemy = enemy_scn.instantiate()
		var position: Vector2 = $EnemyPositions.get_child(i).position
		
		enemy.entity_resource = stage.enemies[i]
		enemy.position = position
		add_child(enemy)
