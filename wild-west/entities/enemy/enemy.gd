extends Entity
class_name Enemy

@onready var player = get_tree().get_first_node_in_group("player") as Player
signal targeted(status: bool)

#var intents: Array[Intent]
var selected_intent: Intent

func _ready() -> void:
	super._ready()
	targeted.connect(toggle_targeted_icon)
	select_random_bullet()

func fire_bullet() -> void:
	var current_intent = $BehaviourMan.currentBehaviour as Intent
	if current_intent:
		current_intent.ChangeBehaviour.emit(current_intent, selected_intent.name)
	else:
		$BehaviourMan.start_with(selected_intent)
	select_random_bullet()

func select_random_bullet() -> void:
	var pool = $BehaviourMan.get_children().duplicate()
	if pool.size() > 1:
		for i in pool.size():
			if pool[i] == selected_intent:
				pool.pop_at(i)
				break
	selected_intent = pool.pick_random()
	$IntentIcon.texture = selected_intent.icon

func death() -> void:
	queue_free()

func toggle_targeted_icon(targeted: bool) -> void:
	$TargetedIcon.visible = targeted

func mirror_entity_resource() -> void:
	super.mirror_entity_resource()
	if entity_resource is EnemyResource:
		for packed_intent in entity_resource.intents:
			
			var intent = packed_intent.instantiate()
			#intents.push_back(intent)
			$BehaviourMan.add_new_behaviour(intent)
