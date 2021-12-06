extends RigidBody

# Variables:
#in order for the forklift to get the updated postion
var picked = false

# In order to change the color of the box and store the pioints for this box
# yellow #FFFF00, points will be 10
#blue #0000FF, points will be 8
#brown, #964B00 , will be 5 points

var rng = RandomNumberGenerator.new()

onready var box = $MeshInstance
var newmaterial = SpatialMaterial.new()
var box_color = null


func _ready():
	make_unique()
	
func _physics_process(delta):
	if picked == true:
		# if the forklift picks up the contianer it shouldnt rotate in the x axis
		self.global_transform.origin = get_parent().get_parent().get_node("Edit_ForkLift").get_node("Box_Position").global_transform.origin
		self.axis_lock_angular_x = true
		
		
# in order to make the box/container follow the forklift we have to keep the box/container updated.
func pickable(status : int):
	if status == 1:
		picked = true
	elif status == 0:
		picked = false
		
func make_unique():
	# pick a random number from 0-2 and change color due to that random number
	rng.randomize()
	var my_num = rng.randi_range(0,2)
	#if my_num == 0:
		#yellow
	#	get_node("MeshInstance").get_surface_material(0).set_paramter(0,Color.yellow)
	#elif my_num == 1:
		#blue
	#	get_node("MeshInstance").get_surface_material(0).set_paramter(0,Color.blue)
	#elif my_num == 2:
		#brown
	#	get_node("MeshInstance").get_surface_material(0).set_paramter(0,Color.brown)
	print(my_num)
	
	if my_num ==0:
		#yellow = Color( 1, 1, 0, 1 ) --- Yellow color.
		newmaterial.albedo_color = Color( 1, 1, 0, 1 ) 
		get_node("MeshInstance").material_override = newmaterial
		box_color = "yellow"
	elif my_num == 1:
		#blue  Color( 0, 0, 1, 1 )
		newmaterial.albedo_color =  Color( 0, 0, 1, 1 )
		get_node("MeshInstance").material_override = newmaterial
		box_color = "blue"
	elif my_num == 2:
		#brown = Color( 0.65, 0.16, 0.16, 1 )
		newmaterial.albedo_color = Color( 0.65, 0.16, 0.16, 1 )
		get_node("MeshInstance").material_override = newmaterial
		box_color = "brown"
