extends Node

signal score_updated
signal time_updated



var score: = 0 setget set_score

#var time: = 0.0 setget set_time, get_time

func reset() -> void:
	score = 0
	


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_score(value: int ) -> void:
	score = value
	emit_signal("Scored_updated")
	
#func set_time(t: double)->void:
#	time = t
