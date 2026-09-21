extends Node2D

func _ready() -> void:
	SaveManager.destroy()
	$AnimationPlayer.play("death_anim")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("start"):
		get_tree().change_scene_to_file("res://screens/main_menu/main_menu.tscn")
