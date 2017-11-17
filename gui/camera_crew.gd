extends Node2D

const CAMERA_SPEED = 200
const CAMERA_ACCEL = 0.8
var actor = null


var velocity = Vector2()
var target_velocity = Vector2()

func _ready():
    get_node("marker").hide()
    set_fixed_process(true)

func set_actor(fella):
    actor = fella
    set_pos(actor.get_pos())


func change_actor(fella):
    actor = fella


func _fixed_process(delta):

    if actor != null:
        var direction = actor.get_pos() - get_pos()
        var length_squared = direction.length_squared()

        if length_squared > 1:

            if length_squared > 20:
                target_velocity = direction.normalized() * CAMERA_SPEED
            else:
                target_velocity = Vector2()
    
            velocity = velocity.linear_interpolate(target_velocity, CAMERA_ACCEL)
            set_pos(get_pos() + velocity * delta)