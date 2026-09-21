extends Node2D

@export var loot_pool: Array[PackedScene]
@export var loot_amount: int = 3
var button_scn = preload("res://common/selectable_ui/selectable_bullet.tscn")

var loot_pointer: int = 0:
	set = set_loot_pointer

func _enter_tree() -> void:
	var save_file:SaveFile = SaveManager.file
	
	var player: PlayerResource = save_file.player_resource
	$SelectablesContainer.ui_selected.connect(_on_ui_selected)
	for bullet_scn: PackedScene in player.bullets:
		var button: SelectableBullet = button_scn.instantiate()
		button.bullet_scn = bullet_scn
		button.pressed.connect(_on_bullet_selected)
		$SelectablesContainer.add_child(button)
	
	if SaveManager.file.stage_number != 0:
		for i in loot_amount:
			var loot_btn: SelectableBullet = button_scn.instantiate()
			var bullet_scn = loot_pool.pick_random()
			loot_btn.bullet_scn = bullet_scn
			$LootContainer.add_child(loot_btn)

func _on_ui_selected(ui: Control) -> void:
	if ui.has_method("selected"):
		update_bullet_info(ui.bullet)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("B"):
		loot_pointer += 1
	if event.is_action_pressed("start"):
		save_game()
		get_tree().change_scene_to_file("res://screens/main_game/main_game.tscn")

func save_game() -> void:
	var player_save: PlayerResource = SaveManager.file.player_resource
	player_save.bullets = gather_selected_bullets()
	SaveManager.save()

func set_loot_pointer(value: int) -> void:
	var old_button: SelectableBullet = $LootContainer.get_child(loot_pointer)
	old_button.unselected()
	if value >= $LootContainer.get_child_count():
		loot_pointer = 0
	else:
		loot_pointer = value
	var button: SelectableBullet = $LootContainer.get_child(loot_pointer)
	button.selected()

func _on_bullet_selected() -> void:
	var selected_btn: SelectableBullet = $SelectablesContainer.selected_ui
	var loot_btn: SelectableBullet = $LootContainer.get_child(loot_pointer)
	var temp = selected_btn.bullet_scn
	selected_btn.bullet_scn = loot_btn.bullet_scn
	loot_btn.bullet_scn = temp
	update_bullet_info(selected_btn.bullet)

func gather_selected_bullets() -> Array[PackedScene]:
	var arr: Array[PackedScene]
	for button: SelectableBullet in $SelectablesContainer.get_children():
		arr.push_back(button.bullet_scn)
	return arr

func update_bullet_info(bullet: Bullet) -> void:
	$CardName.text = bullet.bullet_name
	$Targets.text = str(bullet.target_amount) + " Target(s)"
	$GridContainer/AutoDesc.text = bullet.auto_description
	$GridContainer/ManualDesc.text = bullet.manual_description
