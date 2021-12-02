extends Timer

var cSpawn = preload("res://Assets/Container_Box.tscn")

func _on_Timer_timeout():
	var container_out = cSpawn.instance()
	#container_out.position = Vector3(1,1,1)
	add_child(container_out)
	print("Spawn")
	#wait_time = rand_range(0,1)
