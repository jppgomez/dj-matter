extends Node2D

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("main_menu"):
			SceneTransition.change_scene("res://levels/main menu/main_menu.tscn")
