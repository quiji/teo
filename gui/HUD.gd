extends CanvasLayer

func _ready():
	Glb.set_HUD(self)



func execute_action(action, variables):

	if action == Glb.HUDActions.ThrowChargeBarStart:
		return get_node("throw_charge_bar").start_count()
	elif action == Glb.HUDActions.ThrowChargeBarEnd:
		return get_node("throw_charge_bar").end_count()
	elif action == Glb.HUDActions.Log:
		return get_node("log").set_text(variables)

		
	
