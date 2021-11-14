extends RigidBody

# Variables:
#in order for the forklift to get the updated postion
var picked = false



func _physics_process(delta):
	if picked == true:
		# if the forklift picks up the contianer it shouldnt rotate in the x axis
		self.global_transform.origin = get_parent().get_node("Edit_ForkLift").get_node("Box_Position").global_transform.origin
		self.axis_lock_angular_x = true
		
		
# in order to make the box/container follow the forklift we have to keep the box/container updated.
func pickable(status : int):
	if status == 1:
		picked = true
	elif status == 0:
		picked = false
