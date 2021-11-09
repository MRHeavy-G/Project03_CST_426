extends KinematicBody

var active = true

var y_velo = 0

func _physics_process(delta):
	if active == true:
		$Camera.make_current()
		movement()
	elif !active:
		hide()
		$CollisionShape.disabled = true
		pass



func movement():
	var move_speed = 10
	var jump_force = 35
	var rotate_speed = 2
 
	var gravity = 1.2
	var max_fall_speed = 20
 
	var move_vec = Vector3()
	if Input.is_key_pressed(KEY_W):
		move_vec.z -= 1
	if Input.is_key_pressed(KEY_S):
		move_vec.z += 1
	if Input.is_key_pressed(KEY_D):
		self.rotate_y(deg2rad(-rotate_speed))
	if Input.is_key_pressed(KEY_A):
		self.rotate_y(deg2rad(rotate_speed))
		
	#this will be the command for the worker to get a new camera angle
	#if Input.is_key_pressed(KEY_E):
			# then we have to get a new camera angle and have the "worker disapear"
	#	pass
			
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
 
	move_vec = move_vec.normalized()
	move_vec = move_vec.rotated(Vector3(0, 1, 0), rotation.y)
	move_vec *= move_speed
	move_vec.y = y_velo
	move_and_slide(move_vec, Vector3(0, 1, 0))
 
	var grounded = is_on_floor()
	y_velo -= gravity
	if grounded and y_velo <= 0:
		y_velo = -0.1
	if y_velo < max_fall_speed:
		y_velo = -max_fall_speed


func _on_Exit_Car_Zone_body_exited(body):
	$CollisionShape.disabled = false
	
	
