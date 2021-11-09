extends Control

onready var scene_tree: = get_tree()
onready var paused_overlay: ColorRect = get_node("PausedOverlay")

onready var score: Label = get_node("Label")

var paused: = false setget set_paused 



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerData.connect("score_updated", self, "update_interface")
	updated_interface()
	
	
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(0)
		self.paused = not paused
		scene_tree.set_input_as_handled()

func updated_interface() -> void:
	score.text = "Score: %s" % PlayerData.score

func set_paused(val: bool) -> void:
	paused = val
	scene_tree.paused = val
	paused_overlay.visible = val
	
