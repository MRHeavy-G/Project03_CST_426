extends Timer

#res://Main_Scene.tscn/Container_Space/Container1
var cSpawn = preload("res://Assets/Container_Box.tscn")

func _on_Timer_timeout():
	var container_out = cSpawn.instance()
	
	var newL = container_out.global_transform.origin
	
	#container_out.position = Vector3(1,1,1)
	newL= newL +  - 18 *container_out.global_transform.basis.z
	
	container_out.global_transform.origin = newL
	
	add_child(container_out)
	#print("Spawn")
	wait_time = rand_range(0,10)
	
