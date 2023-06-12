extends Node2D

func _ready():
	if State.key_state == true:
		$Keys.queue_free()
