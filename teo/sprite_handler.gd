extends "res://objects/sprite_handler_base.gd"

func _ready():
    ._ready()

    get_node("AnimationPlayer").connect("finished", self, "on_finished_animation")


func on_finished_animation():
        get_parent().finished_animation(current_action)