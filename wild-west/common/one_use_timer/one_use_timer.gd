extends Timer
class_name LingerTimer

func _init() -> void:
	one_shot = true
	autostart = true

func _ready() -> void:
	pass
	#timeout.connect(queue_free)
