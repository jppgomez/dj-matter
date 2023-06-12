extends CanvasLayer

func _input(event):
	if event.is_action_pressed("inventory"):
		if(!$Inventory.visible):
			GQMVariables.invent_interactions += 1
		else:
			$Inventory/Descriptor.visible = false
			
		$Inventory.visible = !$Inventory.visible
		$Inventory.initialize_inventory()
		
		
