extends Node

var talking: bool = false

var key_status: String = ""

var item_name: String = ""

var item_desc: String = ""

var inventory_full: bool = false

var tool_status: bool = false
var tool_usage = 100
var tool_usage_rate: int
var tool_name: String = ""
var tool_desc: String = ""

var key_state: bool = false

var door_lock: bool = false


func disappear(path: String):
	unlock_door()
	var elem = get_node(path)
	elem.visible = false

func unlock_door():
	door_lock = true
