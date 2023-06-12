extends Area2D

var entered = false

func _on_body_entered(body):
	if body.name == 'Player':
		entered = true


func _on_body_exited(body):
	if body.name == 'Player':
		entered = false
	
	
func _process(_wdelta):
	if entered == true:
		if State.key_state == true:
			var next_scene = "res://levels/house_final/house_final.tscn"
			SceneTransition.change_scene(next_scene)
			
