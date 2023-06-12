extends Node2D

const SlotClass = preload("res://components/inventory/slot.gd")
@onready var inventory_slots = $GridContainer
@onready var equip_slots = $EquipSlots
@onready var tool_slots = $ToolSlots
var holding_item = null

func _ready():
	var slots = inventory_slots.get_children()
	var e_slots = equip_slots.get_children()
	var t_slots = tool_slots.get_children()
	
	for i in range (slots.size()):
		slots[i].connect("gui_input", Callable(self,"slot_gui_input").bind(slots[i]))
		slots[i].slot_index = i
		slots[i].slot_type = SlotClass.SlotType.INVENTORY
	initialize_inventory()
#
	for j in range(e_slots.size()):
		e_slots[j].connect("gui_input", Callable(self,"slot_gui_input").bind(e_slots[j]))
		e_slots[j].slot_index = j
		e_slots[0].slot_type = SlotClass.SlotType.EQUIP
	initialize_equips()
	
	for k in range(t_slots.size()):
		t_slots[k].connect("gui_input", Callable(self,"slot_gui_input").bind(t_slots[k]))
		t_slots[k].slot_index = k
		t_slots[0].slot_type = SlotClass.SlotType.TOOL
	initialize_tools()

func initialize_inventory():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i].initialize_item(PlayerInventory.inventory[i][0], PlayerInventory.inventory[i][1])

func initialize_equips():
	var e_slots = equip_slots.get_children()
	for i in range(e_slots.size()):
		if PlayerInventory.equips.has(i):
			e_slots[i].initialize_item(PlayerInventory.equips[i][0], PlayerInventory.equips[i][1])

func initialize_tools():
	var t_slots = tool_slots.get_children()
	for i in range(t_slots.size()):
		if PlayerInventory.tools.has(i):
			t_slots[i].initialize_item(PlayerInventory.tools[i][0], PlayerInventory.tools[i][1])

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
				if !slot.item:
					left_click_empty_slot()
				else:
					left_click_full_slot(slot)

func left_click_empty_slot():
	if $Descriptor.visible:
		$Descriptor.visible = false

func left_click_full_slot(slot: SlotClass):
	if $Descriptor/MarginContainer/HBoxContainer/VBoxContainer/ItemName.text == slot.item.item_name && $Descriptor.visible:
		$Descriptor.visible = false
	elif $Descriptor/MarginContainer/HBoxContainer/VBoxContainer/ItemName.text == slot.item.item_name && !$Descriptor.visible:	
		$Descriptor.visible = true
		update_desc_data(slot)
	else:
		$Descriptor.visible = true
		update_desc_data(slot)

func update_desc_data(slot: SlotClass):
	GQMVariables.descript_interactions += 1
	$Descriptor/MarginContainer/HBoxContainer/VBoxContainer/ItemName.text = slot.item.item_name
	$Descriptor/MarginContainer/HBoxContainer/ItemImg.texture = load("res://art/items/" + slot.item.item_name + ".png")
	$Descriptor/MarginContainer/HBoxContainer/VBoxContainer/ItemDesc.text = slot.item.item_desc
	
	#tool_description with usage
	if slot.slot_index == 4:
		var tool_desc = slot.item.item_desc + " - (" + str(State.tool_usage) + "%)"
		$Descriptor/MarginContainer/HBoxContainer/VBoxContainer/ItemDesc.text = tool_desc
