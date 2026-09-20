extends GridContainer
class_name SelectablesContainer

@export var use_v_pointer: bool = true
@export var use_h_pointer: bool = false
var v_pointer: int = 0:
	set = set_v_pointer

var selected_ui: SelectableButton
signal ui_selected(selectable: SelectableButton)


func _ready() -> void:
	ui_selected.connect(_on_ui_selected)
	ui_selected.emit(get_child(v_pointer))
	#for child: SelectableButton in get_children():
		#ui_selected.connect()

func _unhandled_input(event: InputEvent) -> void:
	if use_v_pointer:
		if event.is_action_pressed("pad_up"):
			v_pointer -= 1
		elif event.is_action_pressed("pad_down"):
			v_pointer += 1

func set_v_pointer(value: int):
	if value < 0 or value >= get_child_count():
		print("Warning: tried to set V pointer to an out of bounds value")
	else:
		v_pointer = value
	ui_selected.emit(get_child(v_pointer))

func _on_ui_selected(selectable: SelectableButton) -> void:
	if selected_ui:
		selected_ui.unselected()
	selected_ui = selectable
	selected_ui.selected()
