extends Node

var stages: Array[Stage] = [
	ResourceLoader.load("res://stages/stage_one/stage_one.tres"),
]

func fetch(index: int) -> Stage:
	return stages[index]
