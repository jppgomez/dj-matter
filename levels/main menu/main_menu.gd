extends Node2D

@export var mainGameScene : PackedScene
var game_timer_path

func _on_play_button_up():
	game_timer_path = "/root/GQMVariables/GameTimer"
	if(get_node(game_timer_path).is_stopped()):
		get_node(game_timer_path).start()
	SceneTransition.change_scene(mainGameScene.resource_path)


func _on_credits_button_up():
	SceneTransition.change_scene("res://levels/credits/credits.tscn")


func _on_quit_button_up():
	game_timer_path = "/root/GQMVariables/GameTimer"
	get_node(game_timer_path).stop()
	GQMVariables.export_GQM_vars()
	get_tree().quit()


func _on_back_button_up():
	SceneTransition.change_scene("res://levels/main menu/main_menu.tscn")
	
