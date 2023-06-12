extends Node2D

func _ready():
	#timer to blackout and change houses
	var timer = Timer.new()
	timer.set_wait_time(16.0)
	timer.set_one_shot(false)
	timer.timeout.connect(self._repeat_me)
	add_child(timer)
	timer.start()
	
	if State.tool_status == true:
		$Flashlight.queue_free()
	
func _repeat_me():
	#lights off
	if State.tool_status == false || State.tool_usage <= 0:
		$Blackout.visible = true
	
	#hide all colored houses
	$AltTileMap1.visible = false
	$AltTileMap2.visible = false
	$AltTileMap3.visible = false
	$AltTileMap4.visible = false
	$AltTileMap5.visible = false
	
	#select random layer of colored houses
	var rand = int(randf_range(0,5))
	@warning_ignore("integer_division")
	#make visible selected layer
	if rand == 1:
		$AltTileMap1.visible = true
#		$Blackout.visible = false
	elif rand == 2:
		$AltTileMap2.visible = true
#		$Blackout.visible = false
	elif rand == 3:
		$AltTileMap3.visible = true
#		$Blackout.visible = false
	elif rand == 4:
		$AltTileMap4.visible = true
#		$Blackout.visible = false
	elif rand == 5:
		$AltTileMap5.visible = true
#		$Blackout.visible = false
	
	#lights on
	$Lights.play()
	print(rand)
	print($Blackout.visible)	

	await get_tree().create_timer(7.5).timeout
	$Blackout.visible = false

