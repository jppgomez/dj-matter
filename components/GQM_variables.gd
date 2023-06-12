extends Node

#Playfullness
var npc_interactions = 0
var items_collected = 0
var tool_usage = 0
var player_move_time = 0

#Sensemaking
var invent_interactions = 0
var descript_interactions = 0

#Sensoriality
var session_time = 0
var items_found = 0
var interaction_time = 0
var contempl_time = 0

#movement_time_data - for GQM
func _on_move_timer_timeout():
	GQMVariables.player_move_time+=1

#Counts gameplay session time in seconds
func _on_game_timer_timeout():
	GQMVariables.session_time += 1
	
func _on_interaction_timer_timeout():
	GQMVariables.interaction_time += 1

func export_GQM_vars():
	tool_usage = 100 - State.tool_usage
	contempl_time = session_time - player_move_time
	print("Playfullness:")
	print("	NPC Interactions: " + str(npc_interactions))
	print("	Items Collected: " + str(items_collected))
	print("	Tool Usage: " + str(tool_usage))
	print("	Player Movement Time: " + str(player_move_time))
	
	print("Sensemaking:")
	print("	Inventory Interactions: " + str(invent_interactions))
	print("	Descriptions Interactions: " + str(descript_interactions))
	
	print("Sensoriality:")
	print("	Session Time: " + str(session_time))
	print("	Items Found: " + str(items_found))
	print("	Interaction Time: " + str(interaction_time))
	print("	Contemplation Time: " + str(contempl_time))

