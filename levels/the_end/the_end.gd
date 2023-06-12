extends Node2D


func _on_credits_button_up():
	SceneTransition.change_scene("res://levels/credits/credits2.tscn")


func _on_quit_button_up():
	get_tree().quit()
	
