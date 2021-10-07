extends Spatial

var camrot_h = 0
var camrot_v = 0

var cam_v_max = 75
var cam_v_min = -55

var h_sens = 0.1
var v_sens = 0.1

var h_acc = 10
var v_acc = 10

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$H/V/Camera.add_exception(get_parent())

func _input(event):
	if event is InputEventMouseMotion:
		camrot_h += -event.relative.x * h_sens
		camrot_v += -event.relative.y * v_sens
		
func _physics_process(delta):
	
	camrot_v = clamp(camrot_v, cam_v_min, cam_v_max)
	
	$H.rotation_degrees.y = lerp($H.rotation_degrees.y, camrot_h, delta * h_acc)
	$H/V.rotation_degrees.x = lerp($H/V.rotation_degrees.x, camrot_v, delta * v_acc)
