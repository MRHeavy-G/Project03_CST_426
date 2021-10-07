extends KinematicBody

var velocity = Vector3(0,0,0)

const SPEED = 5

func _ready():
	pass


func _physics_process(delta):
	if Input.is_key_pressed(KEY_A) and Input.is_key_pressed(KEY_D):
		velocity.x = 0
	elif Input.is_key_pressed(KEY_D):
		velocity.x = SPEED
	elif Input.is_key_pressed(KEY_A):
		velocity.x = -SPEED
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
		
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()

	move_and_slide(velocity)
