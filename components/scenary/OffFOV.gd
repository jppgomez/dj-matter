extends Area2D

var entered = false

func _on_body_entered(body):
	if body.name == 'Player':
		entered = true
	
func _process(_wdelta):
	if entered == true:
		var path = "/root/" + get_tree().get_current_scene().get_name() + "/FOV"
		get_tree().root.get_node(path).visible = false
			
