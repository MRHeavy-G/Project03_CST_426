extends KinematicBody


# Declare member variables here. Examples:
#These variables will be used for any additonal vechical that can be added in feature developments
export var gravity = -20.0
export var wheel_base = 0.6
export var steering_limit = 10.0
export var engine_power = 6.0
export var braking = -10.0
export var fritction = -2.0
export var drag = -2.0
export var max_speed_reverse = 3.0

# commen physic variables
var acc = Vector3.ZERO
var velocity = Vector3.ZERO
var steer_angle = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if is_on_floor():
		get_input()
		apply_friction(delta)
		calculate_sterring(delta)
	acc.y = gravity
	velocity += acc * delta
	velocity = move_and_slide_with_snap(velocity, -transform.basis.y, Vector3.UP, true)
	

func apply_friction(delta):
	if velocity.length() < 0.2 and acc.length() == 0:
		velocity.x = 0
		velocity.z = 0
	var friction_force = velocity * fritction * delta
	var drag_force  = velocity * velocity.length() * drag * delta
	acc += drag_force + friction_force
	
func calculate_sterring(delta):
	var rear_wheel = transform.origin + transform.basis.z *  wheel_base / 2.0
	var front_wheel = transform.origin - transform.basis.z * wheel_base / 2.0
	rear_wheel +=  velocity * delta
	front_wheel += velocity.rotated(transform.basis.y, steer_angle) * delta
	var new_heading = rear_wheel.direction_to(front_wheel)
	
	var dirct = new_heading.dot(velocity.normalized())
	if dirct > 0:
		velocity = new_heading * velocity.length()
	if dirct < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)
	look_at(transform.origin + new_heading, transform.basis.y)
	
#Overide func
func get_input():
	pass
