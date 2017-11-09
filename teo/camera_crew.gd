extends Node2D

var snipping_ahead = false

func snipe_ahead():
    snipping_ahead = true
    get_node("camera").set_follow_smoothing(3)

func back_to_actor():
    get_node("tween").interpolate_property(self, "transform/pos", get_pos(), Vector2(), 1, Tween.TRANS_CUBIC, Tween.EASE_OUT, 0.5)
    get_node("tween").start()
    snipping_ahead = false
    get_node("camera").set_follow_smoothing(6)


func update_actor_pos(pos, direction):
    if snipping_ahead:
        set_pos(direction * 100)
