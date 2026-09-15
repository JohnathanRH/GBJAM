extends Timer
class_name LingerTimer

func _init(duration: float) -> void:
	one_shot = true
	autostart = true
	wait_time = duration
