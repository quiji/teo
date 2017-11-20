extends "res://objects/sprite_handler_base.gd"

func play_rock_type(rock):
    if rock == Glb.RockTypes.Regular:
        get_node("AnimationPlayer").play("Regular")
        current_action = "Regular"
    elif rock == Glb.RockTypes.Warp:
        get_node("AnimationPlayer").play("Warp")
        current_action = "Warp"
    elif rock == Glb.RockTypes.Shield:
        get_node("AnimationPlayer").play("Shield")
        current_action = "Shield"
