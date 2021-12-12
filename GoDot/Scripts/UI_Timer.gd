extends Control

export (int) var minutes = 0
export (int) var seconds = 0
var dsec = 0

onready var scene_tree: = get_tree()
onready var paused_overlay: ColorRect = get_node("PausedOverlay")
onready var change_tree = get_tree()

func _physics_process(delta):
	
	if minutes > 0 and  seconds <= 0:
		minutes -= 1
		seconds = 60 
		
	
	
	if seconds > 0 and dsec <= 0:
		seconds -= 1
		dsec = 10
		
	
	if seconds >=10:
		$Sec.set_text(str(seconds))
	else:
		$Sec.set_text("0" + str(seconds))
	
	if dsec >= 10:
		$dsec.set_text(str(dsec))
	else:
		$dsec.set_text("0" + str(dsec))
		
	if minutes >=10:
		$Min.set_text(str(minutes))
	else:
		$Min.set_text("0" + str(minutes))
		
	if minutes ==0 and seconds == 0 and dsec == 0:
		get_tree().change_scene("res://Assets/Screens/End_Screne.tscn")
		get_tree().current_scene.add_child(paused_overlay)
		
		
	#	scene_tree.set_input_as_handled()

	
	
func _on_Timer_timeout():
	dsec -=1
