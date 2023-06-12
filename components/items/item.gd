#FOR INVENTORY ITEMS

extends Node2D
var item_name
var item_desc

func set_item(nm, desc):
	item_name = nm
	item_desc = desc
	$TextureRect.texture = load("res://art/items/" + item_name + ".png")
