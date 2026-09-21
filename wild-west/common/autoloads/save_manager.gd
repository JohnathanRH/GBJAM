extends Node

var file: SaveFile
var save_name: String = "my_save"
var default_path: String = "res://save_files/default.tres"
var save_path = "res://save_files/"+save_name+".tres"

func _enter_tree() -> void:
	load_file()

func load_file() -> void:
	if ResourceLoader.exists(save_path):
		file = ResourceLoader.load(save_path)
	else:
		file = ResourceLoader.load("res://save_files/default.tres").duplicate()
		save()

func save() -> void:
	ResourceSaver.save(file, save_path)

func destroy() -> void:
	if ResourceLoader.exists(save_path):
		file = null
		DirAccess.remove_absolute(save_path)
		load_file()
