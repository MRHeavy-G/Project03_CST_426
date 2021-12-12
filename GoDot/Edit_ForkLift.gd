extends "res://Scripts/Auto_Mobil_Basic.gd"

#addes the accesablity for the forklift and the exit status
var active = false

var car_zone = false

var body_CE = false

#tells the player if the box can be picked up or not
var object_Ineraction = false

# these variables will add the options to pick up the containers in the game 
var score_Zone = false

var container_picked_up = false

var active_con1 = false
var active_con4 = false

#movement for the forklift
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
			
		#if Input.is_key_pressed(KEY_ESCAPE):
		#	get_tree().quit()
		
		leaving_car()
		
		
		#this call will be to pcik up the objects 
		if(object_Ineraction  == true):
			pick_up_objects()
		
		#if we are no longer in the scoring zone we can let go of the boxs location
		check_to_see_if_con2_active()
		
	elif active == false:
		entering_car()
		
		

#object inveractions once on the main floor
#------------------------------------------
func pick_up_objects():
	# to get the mesh for the box
	var vehcile = $"."
	var container1 = get_parent().get_node("Container_Space/Container1")
	var container4 = get_parent().get_node("Container_Space/Container4")
	var container5 = get_parent().get_node("Container_Space/Container5")
	
	var active_container = 0
	
	#points for the contianer
	var containerPoints;
	
	
	if Input.is_action_just_pressed("ui_q") == true && object_Ineraction == true:
		# if we know that the key was pressed we can safely say that the container was picked up
		#container_picked_up = true
		#newContainerLoc = newContainerLoc +  2.5 *-vehcile.global_transform.basis.z
		if active_con1 == true:
			active_container = 1
			container1.pickable(1)
			
		if active_con4 == true:
			active_container = 4
			container4.pickable(1)
			
		
		
		#container1.global_transform.origin = newContainerLoc
		#vehcile.add_child(container1)
		#container1.set_physics_process(false)
		#container1.global_transform.origin = vehcile.global_transform.origin
	#if container2.get_node("Box/Box1_Pick_Up_Area").NOTIFICATION_ENTER_TREE:
	#		active_container = 2
	#		container2.get_node("Box").pickable(1)
	#if container3.get_node("Box/Box1_Pick_Up_Area").NOTIFICATION_ENTER_TREE:
	#	active_container = 3
	#	container3.get_node("Box").pickable(1)
		
	if Input.is_action_just_pressed("ui_q") == true && score_Zone == true :
		var userInterface = get_parent().get_node("UserInterface/UserInterface")
		#print("Point added")
		
		# this function will return the amount of points percontainer
		containerPoints = color_Score()
		#this will depend on what container the forklift has
		PlayerData.score +=containerPoints
		userInterface.updated_interface()
		
		if active_container == 1:
			container1.pickable(0)
			active_con1 = false
		
		if active_container == 4:
			container4.pickable(0)
			active_con4 = false
			
		active_container = 0
		object_Ineraction = false
		
	#if active_container == 2:
	#		container2.get_node("Box").pickable(0)
	#if active_container == 3:
	#	container3.get_node("Box").pickable(0)
		
	# finally we need to check and see if th object has been dropped in the zone and it must stay there
	 

func color_Score():
	# in order to get the proper point for the container "type"
	var cColor = get_parent().get_node("Container_Space/Container1")
	if cColor.box_color == "blue":
		return 3
	elif cColor.box_color == "yellow":
		return 5
	elif cColor.box_color == "brown":
		return 1


#entering and leaving the forklift commands
#-----------------------------------------------------

func entering_car():
	if Input.is_action_just_pressed("ui_e") && car_zone == true:
		var hide_player = get_parent().get_node("Worker")
		
		hide_player.active = false
		$Camera.make_current()
		active = true
		
func leaving_car():
	var vehicle = $"."
	var hide_player = get_parent().get_node("Worker")
	var newLoc = vehicle.global_transform.origin 
	#print(vehicle.global_transform.origin)
	#newLoc =  newLoc + 25*vehicle.global_transform.basis.x 
	#newLoc =  newLoc - 15*vehicle.global_transform.basis.z 
	newLoc = newLoc + 5 *vehicle.global_transform.basis.y
	#print(newLoc, "New")
	
	if car_zone ==  false && Input.is_action_just_pressed("ui_e") && body_CE == true:
		
		active = false
		
		hide_player.active = true
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
func _on_Box1_Pick_Up_Area_body_entered(body):
	if body.name == "Edit_ForkLift":
		object_Ineraction = true
		active_con1 = true

func _on_Box1_Pick_Up_Area_body_exited(body):
	##if body.name == "Edit_ForkLift":
	##	object_Ineraction = false
	pass

func _on_Drop_off_section_for_points_body_entered(body):
	# in here we will check to see if the forklift is in the area to gather point with a box on the forks
	if body.name == "Edit_ForkLift":
		
		score_Zone = true
	
	
func _on_Drop_off_section_for_points_body_exited(body):
	if body.name == "Edit_ForkLift":
		score_Zone = false
	
	
	
func check_to_see_if_con2_active():
	var container2 = get_parent().get_node("Container_Space/Container2")
	
	
	if container2.get_node("Box/Box1_Pick_Up_Area").emit_signal("body_entered"):
		#then we know that we can at least get the noticifaction to work
		print("Container2 Notification")
		



func _on_Box4_Pick_Up_Area_body_entered(body):
	object_Ineraction = true
	active_con4 = true
