#FOR DETECTING ITEM PICKUP + DAILOGUE

extends Area2D

const Balloon = preload("res://components/dialogue/balloon.tscn")

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = ""
@export var item_name: String = ""
@export var item_desc: String = ""
@export var chance_of_playing: int
@export var tool_usage_rate: int 	##number of points out of 100 the tool reduces every second

var being_picked_up = false

func action() -> void:
	if item_name:
		State.item_name = item_name
		State.item_desc = item_desc
	
	if tool_usage_rate:
		State.tool_name = item_name
		State.tool_desc = item_desc
		State.tool_usage_rate = tool_usage_rate
		
		
	var balloon: Node = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
#	if $ItemCollect != null:
#		$ItemCollect.play()
	State.talking = true
	balloon.start(dialogue_resource, dialogue_start)
	
	var desc_path = "/root/" + get_tree().get_current_scene().get_name() + "/Toolbar/Inventory/Descriptor"
	if get_tree().root.get_node(desc_path).visible:
		get_tree().root.get_node(desc_path).visible = false
	
	if item_name != "Consumable":
		queue_free()
#	if being_picked_up == true:
#		$ItemCollect.play()

func _ready():
	var timer = Timer.new()
	timer.set_wait_time(2.0)
	timer.set_one_shot(false)
	timer.timeout.connect(self._repeat_me)
	add_child(timer)
	timer.start()

	
func _repeat_me():
	#fix chance of playing
	var rand = int(randf_range(0,10))
	@warning_ignore("integer_division")
	if rand < int(chance_of_playing):
		$ItemLocator.play()
#	print(rand)	
