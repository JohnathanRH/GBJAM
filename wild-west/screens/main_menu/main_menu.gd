extends Node2D

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/main_game/main_game.tscn")

func _on_options_pressed() -> void:
	print("Opening your options")
