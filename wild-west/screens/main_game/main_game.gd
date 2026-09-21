extends Node2D

var enemy_scn = preload("res://entities/enemy/enemy.tscn")

func _enter_tree() -> void:
	$Player.entity_resource = SaveManager.file.player_resource
	var stage_num: int = SaveManager.file.stage_number
	
	var stage: Stage = Stages.fetch(stage_num)
	for i in stage.enemies.size():
		var enemy: Enemy = enemy_scn.instantiate()
		var position: Vector2 = $EnemyPositions.get_child(i).position
		
		enemy.entity_resource = stage.enemies[i]
		enemy.position = position
		enemy.dead.connect(_on_enemy_death)
		add_child(enemy)

func _on_enemy_death(enemy: Entity) -> void:
	$VictoryDelay.start()
	#print("An enemy has died")

func _on_victory_delay_timeout() -> void:
	var enemies_alive = get_tree().get_node_count_in_group("enemies")
	if enemies_alive == 0:
		if SaveManager.file.stage_number >= Stages.stages.size()-1:
			get_tree().change_scene_to_file("res://screens/ending/ending_scene.tscn")
		else:
			get_tree().change_scene_to_file("res://screens/bullet_pick/bullet_pick.tscn")
