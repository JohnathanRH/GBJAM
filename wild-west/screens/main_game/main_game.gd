extends Node2D

func _enter_tree() -> void:
	$Player.entity_resource = SaveManager.file.player_resource
