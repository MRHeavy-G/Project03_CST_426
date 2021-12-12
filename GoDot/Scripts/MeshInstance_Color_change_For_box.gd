extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()




# Called when the node enters the scene tree for the first time.
func _ready():
	make_unique()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func make_unique():
	# pick a random number from 0-2 and change color due to that random number
	rng.randomize()
	var my_num = rng.randf_range(0,2)
	if my_num == 0:
		#yellow
		get_node("MeshInstance").get_surface_material(0).set_paramter(0,Color.yellow)
	elif my_num == 1:
		#blue
		get_node("MeshInstance").get_surface_material(0).set_paramter(0,Color.blue)
	elif my_num == 2:
		#brown
		get_node("MeshInstance").get_surface_material(0).set_paramter(0,Color.brown)
