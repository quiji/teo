extends Node2D
var actor = null
var snipping = false

func _ready():
    get_node("marker").hide()
    set_fixed_process(true)

func set_actor(fella):
    actor = fella
    set_pos(actor.get_pos())
    actor.connect("moved", self, "on_actor_moved")

func snipe_ahead(target):
    get_node("tween").interpolate_property(self, "transform/pos", target, get_pos(), 1, Tween.TRANS_CUBIC, Tween.EASE_OUT, 0.5)
    get_node("tween").start()
    get_node("camera").set_follow_smoothing(1)
    snipping = true

func back_to_actor():
    get_node("camera").set_follow_smoothing(6)
    snipping = false

func on_actor_moved(fella):
    if not snipping:
        set_pos(actor.get_pos())