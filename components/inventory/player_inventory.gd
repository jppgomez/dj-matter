extends Node
const SlotClass = preload("res://components/inventory/slot.gd")
const ItemClass = preload("res://components/items/item.gd")
const NUM_INVENTORY_SLOTS = 3

#current inventory data
var inventory = { #--> slot index: [item_name][item_desc]

}

var equips = { #--> slot index: [item_name][item_desc]

}

var tools = { #--> slot index: [item_name][item_desc]

}

#add any item to inventory
func add_item(item_name, item_desc, item_cell):
	GQMVariables.items_collected+=1
	#cosmetic items
	if item_cell == 3:
		if equips.has(0) == false:
			equips[0] = [item_name, item_desc]
			update_cosmetic_slot_visuals(item_name, item_desc)
		else:
			equips[0][0] = item_name
			equips[0][1] = item_desc
			update_cosmetic_slot_visuals(item_name, item_desc)
	#tools items
	elif item_cell == 4:
		if tools.has(0) == false:
			tools[0] = [item_name, item_desc]
			State.tool_status = true
			State.tool_usage = 100
			update_tool_slot_visuals(item_name, item_desc)
		else:
			tools[0][0] = item_name
			tools[0][1] = item_desc
			State.tool_status = true
			update_tool_slot_visuals(item_name, item_desc)
	#regular items	
	else:
		for item in inventory:
			#already has item
			if inventory[item][0] == item_name:
				return
		#inventory almost full -> last item (1 slot left)	
		if inventory.size() < NUM_INVENTORY_SLOTS:
			if inventory.size() == NUM_INVENTORY_SLOTS-1:
				State.inventory_full = true
		#inventory has space -> add to end
		if item_cell == -1:		
			for i in range(NUM_INVENTORY_SLOTS):
				if inventory.has(i) == false:
					inventory[i] = [item_name, item_desc]
					update_slot_visual(i, inventory[i][0], inventory[i][1])
					return	
		#inventory full -> has to choose / replace			
		else:
			inventory[item_cell] = [item_name, item_desc]
			update_slot_visual(item_cell, inventory[item_cell][0], inventory[item_cell][1])
			return	
		
#update inventory gui visuals
func update_slot_visual(slot_index, item_name, item_desc):
	#set toolbar inventory to visible when item is picked up
	var toolbar_path = "/root/" + get_tree().get_current_scene().get_name() + "/Toolbar/Inventory"
	get_tree().root.get_node(toolbar_path).visible = true
	#update item description data and set panel to visible
	var desc_path = "/root/" + get_tree().get_current_scene().get_name() + "/Toolbar/Inventory/Descriptor"
	get_tree().root.get_node(desc_path + "/MarginContainer/HBoxContainer/VBoxContainer/ItemName").text = item_name
	get_tree().root.get_node(desc_path + "/MarginContainer/HBoxContainer/ItemImg").texture = load("res://art/items/" + item_name + ".png")
	get_tree().root.get_node(desc_path + "/MarginContainer/HBoxContainer/VBoxContainer/ItemDesc").text = item_desc
	get_tree().root.get_node(desc_path).visible = true
	
	var path = "/root/" + get_tree().get_current_scene().get_name() + "/Toolbar/Inventory/GridContainer/Slot"
	var slot = get_tree().root.get_node(path + str(slot_index + 1))
	if slot.item != null:
		slot.item.set_item(item_name, item_desc)
	else:
		slot.initialize_item(item_name, item_desc)
		
func update_cosmetic_slot_visuals(item_name, item_desc):
	#set toolbar inventory to visible when item is picked up
	var toolbar_path = "/root/" + get_tree().get_current_scene().get_name() + "/Toolbar/Inventory"
	get_tree().root.get_node(toolbar_path).visible = true
	#update item description data and set panel to visible
	var desc_path = "/root/" + get_tree().get_current_scene().get_name() + "/Toolbar/Inventory/Descriptor"
	get_tree().root.get_node(desc_path + "/MarginContainer/HBoxContainer/VBoxContainer/ItemName").text = item_name
	get_tree().root.get_node(desc_path + "/MarginContainer/HBoxContainer/ItemImg").texture = load("res://art/items/" + item_name + ".png")
	get_tree().root.get_node(desc_path + "/MarginContainer/HBoxContainer/VBoxContainer/ItemDesc").text = item_desc
	get_tree().root.get_node(desc_path).visible = true
	
	var path = "/root/" + get_tree().get_current_scene().get_name() + "/Toolbar/Inventory/EquipSlots/EquipSlot"
	var eslot = get_tree().root.get_node(path)
	if eslot.item != null:
		eslot.item.set_item(item_name, item_desc)
	else:
		eslot.initialize_item(item_name, item_desc)	
		
func update_tool_slot_visuals(item_name, item_desc):
	#set toolbar inventory to visible when item is picked up
	var toolbar_path = "/root/" + get_tree().get_current_scene().get_name() + "/Toolbar/Inventory"
	get_tree().root.get_node(toolbar_path).visible = true
	#update item description data and set panel to visible
	var desc_path = "/root/" + get_tree().get_current_scene().get_name() + "/Toolbar/Inventory/Descriptor"
	get_tree().root.get_node(desc_path + "/MarginContainer/HBoxContainer/VBoxContainer/ItemName").text = item_name
	get_tree().root.get_node(desc_path + "/MarginContainer/HBoxContainer/ItemImg").texture = load("res://art/items/" + item_name + ".png")
	get_tree().root.get_node(desc_path + "/MarginContainer/HBoxContainer/VBoxContainer/ItemDesc").text = item_desc
	get_tree().root.get_node(desc_path).visible = true
	
	var path = "/root/" + get_tree().get_current_scene().get_name() + "/Toolbar/Inventory/ToolSlots/ToolSlot"
	var tslot = get_tree().root.get_node(path)
	if tslot.item != null:
		tslot.item.set_item(item_name, item_desc)
	else:
		tslot.initialize_item(item_name, item_desc)			
