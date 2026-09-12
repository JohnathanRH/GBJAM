extends Node2D
class_name GaugeBar

var icon_scn = preload("res://common/gauge_icon/gauge_icon.tscn")

@export var duration: float = 2.0
@export var icon_offset: float = 7.0

#var icons: Dictionary[Entity, GaugeIcon]
var end_position: Vector2

func _ready() -> void:
	var width = $Bar.texture.get_width() * $Bar.scale.x
	end_position = Vector2(width, $Bar.position.y - icon_offset)
	
	for entity in get_tree().get_nodes_in_group("entities"):
		var icon = icon_scn.instantiate() as GaugeIcon
		icon.start_position = Vector2(0, $Bar.position.y - icon_offset)
		icon.end_position = end_position
		icon.entity = entity
		
		add_child(icon)
		#icons[entity] = icon
