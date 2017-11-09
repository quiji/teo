extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	get_node("area").connect("body_enter", self, "on_body_enter")


func on_body_enter(body):
	if body.get_object_type() == Glb.ObjectTypes.Teo:
		body.pick(Glb.ObjectTypes.Bullet)
		queue_free()

func get_object_type(): return Glb.ObjectTypes.Pickable