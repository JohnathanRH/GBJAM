extends Node

var battle_bgm = preload("res://props/music/battle_music.tscn")

func _ready() -> void:
	var bgm = battle_bgm.instantiate() as AudioStreamPlayer
	add_child(bgm)
	bgm.play()
