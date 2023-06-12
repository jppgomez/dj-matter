extends Panel

var default_tex = preload("res://art/ui/cell_default.png")
var empty_tex = preload("res://art/ui/cell_empty.png")

#
var default_style: StyleBoxTexture = null
var empty_style: StyleBoxTexture = null
var selected_style: StyleBoxTexture = null
#
var ItemClass = preload("res://components/items/item.tscn")
var item = null
var slot_index
var slot_type

enum SlotType {
	INVENTORY,
	EQUIP,
	TOOL
}

func _ready():
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	selected_style = StyleBoxTexture.new()
	default_style.texture = default_tex
	empty_style.texture = empty_tex
	
	refresh_style()
		
func refresh_style():
	if item == null:
		set('theme_override_styles/panel', empty_style)
	else:
		set('theme_override_styles/panel', default_style)

func initialize_item(item_name, item_desc):
	if item == null:
		item = ItemClass.instantiate()
		add_child(item)
		item.set_item(item_name, item_desc)
	else:
		item.set_item(item_name, item_desc)
	refresh_style()

