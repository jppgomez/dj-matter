extends CharacterBody2D
# @export sets variable to inspector
@export var move_speed : float = 100
@export var starting_direction: Vector2 = Vector2(0,1)

# parameters/Idle/blend_position

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var actionable_finder: Area2D = $Direction/ActionableFinder
@onready var items_finder: Area2D = $Direction/ItemFinder

@onready var walk = $Walking
@onready var wrong = $WrongAction

@export var walking_sound: AudioStreamMP3

var using_tool = false
@onready var tool_timer = $ToolTimer

func _ready():
	$Walking.stream = walking_sound
	update_animation_parameters(starting_direction)

#interaction
func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pickup"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			
		var items = items_finder.get_overlapping_areas()
		if items.size() > 0:
			items[0].action()
		
		if items.size() <= 0 && actionables.size() <= 0:
			wrong.play()
				
			return 		
	
	#tool usage
	if State.tool_status:	
		if Input.is_action_just_pressed("tool"):
			if(!using_tool):
				tool_timer.start()
			else:
				tool_timer.stop()
			using_tool = !using_tool
		
	if using_tool:
		var path = "/root/" + get_tree().get_current_scene().get_name() + "/FOV"
		get_node(path).visible = false
		
	else:
		var path = "/root/" + get_tree().get_current_scene().get_name() + "/FOV"
		get_node(path).visible = true		
	
		
#movement
func _physics_process(_delta):
	#get input direction
	var input_direction = Vector2(
		#se carregar nos 2 ao mesmo tempo nao move
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	#move and slide funct uses vel of char body to move character on map
	if State.talking == true:
		update_animation_parameters(Vector2.ZERO)
		velocity = Vector2.ZERO
		pick_new_state()
	else:
		#print(input_direction)
		update_animation_parameters(input_direction)
		#update velocity
		velocity = input_direction * move_speed
		move_and_slide()
		pick_new_state()


func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)

func pick_new_state():
	if(velocity != Vector2.ZERO):
		if(get_node("/root/GQMVariables/MoveTimer").is_stopped()):
			get_node("/root/GQMVariables/MoveTimer").start()
			
		state_machine.travel("Walk")
		if walk.playing == false:
			walk.play()
	else:
		get_node("/root/GQMVariables/MoveTimer").stop()
		state_machine.travel("Idle")

#tool_usage
func _on_tool_timer_timeout():
	if(State.tool_usage > State.tool_usage_rate):
		State.tool_usage = State.tool_usage - State.tool_usage_rate	
		var tool_desc = State.tool_desc + " - (" + str(State.tool_usage) + "%)"
		var name_path = "/root/" + get_tree().get_current_scene().get_name() + "/Toolbar/Inventory/Descriptor/MarginContainer/HBoxContainer/VBoxContainer/ItemName"
		var img_path = "/root/" + get_tree().get_current_scene().get_name() + "/Toolbar/Inventory/Descriptor/MarginContainer/HBoxContainer/ItemImg"
		var desc_path = "/root/" + get_tree().get_current_scene().get_name() + "/Toolbar/Inventory/Descriptor/MarginContainer/HBoxContainer/VBoxContainer/ItemDesc"
		get_tree().root.get_node(name_path).text = State.tool_name
		get_tree().root.get_node(img_path).texture = load("res://art/items/" + State.tool_name + ".png")
		get_tree().root.get_node(desc_path).text = tool_desc
	else:
		State.tool_status = false
		using_tool = false	
		tool_timer.stop()
	#print(State.tool_usage)

