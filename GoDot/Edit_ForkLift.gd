extends "res://Scripts/Auto_Mobil_Basic.gd"

var active = false

var car_zone = false

var body_CE = false

func get_input():
	
	
	
	
	if active == true:
		$Camera.make_current()
		
		var turn = Input.get_action_strength("steer_left")
		turn -= Input.get_action_strength("steer_right")
		steer_angle = turn * deg2rad(steering_limit)
		$tmpParent/tractor/wheel_frontRight.rotation.y = steer_angle * 2
		$tmpParent/tractor/wheel_frontLeft.rotation.y = steer_angle * 2
		acc = Vector3.ZERO
		if Input.is_action_pressed("accelerate"):
			acc = -transform.basis.z * engine_power
		if Input.is_action_pressed("brake"):
			acc = -transform.basis.z * braking
			
		if Input.is_key_pressed(KEY_ESCAPE):
			get_tree().quit()
		
		leaving_car()
		
	elif active == false:
		entering_car()
		pass
		

func entering_car():
	if Input.is_action_just_pressed("ui_e") && car_zone == true:
		var hide_player = get_parent().get_node("Worker")
		
		hide_player.active = false
		$Camera.make_current()
		active = true
		
func leaving_car():
	var vehicle = $"."
	var hide_player = get_parent().get_node("Worker")
	var newLoc = vehicle.global_transform.origin - 2*vehicle.global_transform.basis.x 
	
	if car_zone ==  false && Input.is_action_just_pressed("ui_e") && body_CE == true:
		hide_player.active = true
		active = false
		hide_player.global_transform.origin = newLoc


func _on_Player_Interaction_body_entered(body):
	if body.name == "Worker":
		car_zone = true
		

func _on_Exit_Car_Zone_body_exited(body):
	if body.name == "Edit_ForkLift":
		body_CE = false
		print("can_if")


func _on_Player_Interaction_body_exited(body):
	if body.name == "Worker":
		car_zone = false
		



func _on_Exit_Car_Zone_body_entered(body):
	if body.name == "Edit_ForkLift":
		body_CE = true