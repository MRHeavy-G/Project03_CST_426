extends Control

onready var score: Label = get_node("End_Score")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(0)
	update_score()

func update_score() -> void:
	score.text = "%s" % PlayerData.score
