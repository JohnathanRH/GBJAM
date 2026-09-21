extends Node2D

var cutscene_ends: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("start") and cutscene_ends:
		SaveManager.destroy()
		get_tree().change_scene_to_file("res://screens/main_menu/main_menu.tscn")

func _ready() -> void:
	$AnimationPlayer.play("player_win")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	cutscene_ends = true
