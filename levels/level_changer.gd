extends Area2D

var entered = false

@export var next_level: String = ""

func _on_body_entered(body):
	if body.name == 'Player':
		entered = true


func _on_body_exited(body):
	if body.name == 'Player':
		entered = false
	
	
func _process(_wdelta):
	if entered == true:
		if State.door_lock == true:
			var next_scene = "res://levels/" + next_level + "/" + next_level + ".tscn"
			SceneTransition.change_scene(next_scene)
			State.door_lock = false
			
