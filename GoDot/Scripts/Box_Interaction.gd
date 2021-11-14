extends RigidBody

var picked = false

func _physics_process(delta):
	if picked == true:
		self.global_transform.origin = get_parent().get_node("Edit_ForkLift").get_node("Box_Position").global_transform.origin
		
# in order to make the box/container follow the forklift we have to keep the box/container updated.
func pickable(status : int):
	if status == 1:
		picked = true
	elif status == 0:
		picked = false
