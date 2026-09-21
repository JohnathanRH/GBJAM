extends Node

var stages: Array[Stage] = [
	ResourceLoader.load("res://stages/stage_one/stage_one.tres"),
	ResourceLoader.load("res://stages/stage_one/stage_two.tres"),
	ResourceLoader.load("res://stages/stage_one/stage_three.tres"),
	ResourceLoader.load("res://stages/stage_one/stage_four.tres")
]

func fetch(index: int) -> Stage:
	return stages[index]
