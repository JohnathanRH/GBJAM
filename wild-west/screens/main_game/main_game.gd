extends Node2D

var enemy_scn = preload("res://entities/enemy/enemy.tscn")

@export var random_strength: float = 2.0
@export var shake_duration: float = 0.2
var tween: Tween

func _enter_tree() -> void:
	$Player.entity_resource = SaveManager.file.player_resource
	var stage_num: int = SaveManager.file.stage_number
	
	$Player.damage_received.connect(_on_player_damaged)
	$Player.auto_fired.connect(_on_player_fired)
	
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
			var save_file:SaveFile = SaveManager.file
			save_file.stage_number += 1
			SaveManager.save()
			
			get_tree().change_scene_to_file("res://screens/bullet_pick/bullet_pick.tscn")

func _on_player_damaged() -> void:
	_shake_camera()

func _on_player_fired() -> void:
	_shake_camera()

func _shake_camera() -> void:
	if tween and tween.is_running():
		tween.kill()
	
	tween = create_tween().set_parallel(false)
	
	var original_offset = %Camera.offset
	
	for i in range(5):
		var offset = Vector2(
			original_offset.x + randf_range(-random_strength, random_strength),
			original_offset.y + randf_range(-random_strength, random_strength)
			)
		tween.tween_property(%Camera, "offset", offset, shake_duration / 5.0)
	tween.tween_property(%Camera, "offset", original_offset, shake_duration / 5.0)
