#DUCK TYPED
extends GridContainer
class_name SelectablesContainer

@export var use_v_pointer: bool = true
@export var use_h_pointer: bool = false
var h_pointer: int = 0:
	set = set_h_pointer

var selected_ui: Control
signal ui_selected(selectable: Control)


func _ready() -> void:
	ui_selected.connect(_on_ui_selected)
	ui_selected.emit(get_child(h_pointer))
	#for child: SelectableButton in get_children():
		#ui_selected.connect()

func _unhandled_input(event: InputEvent) -> void:
	if use_v_pointer:
		if event.is_action_pressed("pad_left"):
			h_pointer -= 1
		elif event.is_action_pressed("pad_right"):
			h_pointer += 1
		
		if event.is_action_pressed("pad_up"):
			h_pointer -= columns
		elif event.is_action_pressed("pad_down"):
			h_pointer += columns

func set_h_pointer(value: int):
	if value < 0 or value >= get_child_count():
		print("Warning: tried to set V pointer to an out of bounds value")
	else:
		h_pointer = value
	ui_selected.emit(get_child(h_pointer))

func _on_ui_selected(selectable: Control) -> void:
	if selectable.has_method("selected") and selectable.has_method("unselected"):
		if selected_ui:
			selected_ui.unselected()
		selected_ui = selectable
		selected_ui.selected()
