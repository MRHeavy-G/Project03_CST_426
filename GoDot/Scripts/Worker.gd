extends KinematicBody

var velocity = Vector3.ZERO

const SPEED = 5

var active = true

func _ready():
	pass


func _physics_process(delta):
	if active == true:
		if Input.is_key_pressed(KEY_A) and Input.is_key_pressed(KEY_D):
			velocity.x = 0
		elif Input.is_key_pressed(KEY_D):
			#velocity.x = SPEED
			self.rotate_y(deg2rad(-2))
			
		elif Input.is_key_pressed(KEY_A):
			#velocity.x = -SPEED
			self.rotate_y(deg2rad(2))
			
			
		else:
			velocity.x = lerp(velocity.x, 0 , 0.1) 

		if Input.is_key_pressed(KEY_W) and Input.is_key_pressed(KEY_S):
			velocity.z = 0
		elif Input.is_key_pressed(KEY_W):
			velocity.z = -SPEED
		elif Input.is_key_pressed(KEY_S):
			velocity.z = SPEED 
		else:
			velocity.z = lerp(velocity.z, 0 , 0.1)
			
		#this will be the command for the worker to get a new camera angle
		if Input.is_key_pressed(KEY_E):
			# then we have to get a new camera angle and have the "worker disapear"
			pass
			
		if Input.is_key_pressed(KEY_ESCAPE):
			get_tree().quit()
	elif !active:
		pass

	move_and_slide(velocity)
