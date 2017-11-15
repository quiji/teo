extends "res://objects/sprite_handler_base.gd"

func _ready():
    ._ready()

    if get_node("AnimationPlayer").has_animation("Regular"):
        get_node("AnimationPlayer").play("Regular")
        current_action = "Regular"