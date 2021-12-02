extends Control

export (int) var minutes = 0
export (int) var seconds = 0
var dsec = 0

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
		
	#Once the timer reaches 0:0:0 then we can quite the game or go to the pause menu
	#if minutes ==0 and seconds == 0:
		
	
func _on_Timer_timeout():
	dsec -=1
