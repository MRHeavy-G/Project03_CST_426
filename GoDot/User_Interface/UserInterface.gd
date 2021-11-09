extends Control

onready var scene_tree: = get_tree()
onready var paused_overlay: ColorRect = get_node("PausedOverlay")

var paused: = false setget set_paused 



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(0)
		self.paused = not paused
		scene_tree.set_input_as_handled()

func set_paused(val: bool) -> void:
	paused = val
	scene_tree.paused = val
	paused_overlay.visible = val
	
