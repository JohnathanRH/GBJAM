extends Sprite2D
class_name GaugeIcon

var duration: float
var end_position: Vector2
var tween: Tween

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play() -> void:
	if !tween or !tween.is_valid():
		tween = create_tween()
	tween.tween_property(self, "position", end_position, duration)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.play()

func slow(speed_scale: float):
	tween.set_speed_scale(speed_scale)
