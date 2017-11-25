extends CanvasLayer

func _ready():
	Glb.set_HUD(self)



func execute_action(action, variables):

	if action == Glb.HUDActions.ThrowChargeBarStart:
		return get_node("throw_charge_bar").start_count()
	elif action == Glb.HUDActions.ThrowChargeBarEnd:
		return get_node("throw_charge_bar").end_count()
	elif action == Glb.HUDActions.PushRock:
		return get_node("satchel_control").push_rock(variables)
	elif action == Glb.HUDActions.HoldRock:
		return get_node("satchel_control").hold_rock()
	elif action == Glb.HUDActions.PopRock:
		return get_node("satchel_control").pop_rock()
	elif action == Glb.HUDActions.SwapRock:
		return get_node("satchel_control").swap_rock()
	elif action == Glb.HUDActions.CancelRock:
		return get_node("satchel_control").cancel_rock()
	elif action == Glb.HUDActions.Log:
		return get_node("log").set_text(variables)

		
	
