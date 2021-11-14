extends "res://Scripts/Auto_Mobil_Basic.gd"

var active = false

var car_zone = false

var body_CE = false

<<<<<<< Updated upstream
=======
#tells the player if the box can be picked up or not
var object_Ineraction = false

# these variables will add the options to pick up the containers in the game 
var score_Zone = false

var container_picked_up = false

var box1_event = false


#movement for the forklift
>>>>>>> Stashed changes
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
		

<<<<<<< Updated upstream
=======
#object inveractions once on the main floor
#------------------------------------------
func pick_up_objects():
	# to get the mesh for the box
	var vehcile = $"."
	var container1 = get_parent().get_node("Box")
	
	
	if Input.is_action_just_pressed("ui_q") == true:
		# if we know that the key was pressed we can safely say that the container was picked up
		container_picked_up = true
		box1_event = true
		
		
		#container1.global_transform.origin = vehcile.get_node("Box_Position").global_transform.origin
		container1.pickable(1)
		
		
		#container1.move_and_slide(vehcile.get_node("Box_Position").global_transform.origin)
		
		# reset after the interaction
		#container_picked_up = false
		#box1_event = false
		
		
		
		print("ACtion_Q")
	if Input.is_action_just_pressed("ui_q") == true && score_Zone == true:
		print("Point added")
		
		container1.pickable(0)
		
		#this will depend on what container the forklift has
		PlayerData.score +=1
		
		
		
		#this will be so that the player can only get one point at a time
		#vehcile.container_picked_up = false
		#vehcile.object_Ineraction = false
		
	
	




#entering and leaving the forklift commands
#-----------------------------------------------------

>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======


#if we are in the area zone for box1 then we can pick up the box
func _on_Box1_Pick_Up_Area_body_entered(body):
	if body.name == "Edit_ForkLift":
		object_Ineraction = true
		print("IN_AREA_BOX")
	
	


func _on_Drop_off_section_for_points_body_entered(body):
	# in here we will check to see if the forklift is in the area to gather point with a box on the forks
	if body.name == "Edit_ForkLift" :
		if container_picked_up == true:
			score_Zone = true
	print(score_Zone)
		
	
>>>>>>> Stashed changes
