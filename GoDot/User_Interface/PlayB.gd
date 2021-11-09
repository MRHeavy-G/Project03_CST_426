tool

extends Button

export(String, FILE) var next_scene_path: = ""

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayB_button_up():
	get_tree().change_scene(next_scene_path)


func _get_configuration_warning() -> String:
	return "next scene must be set before you continue" if next_scene_path == "" else ""
