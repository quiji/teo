extends Node2D

var velocity = Vector2()

func _ready():
	get_node("area").connect("body_enter", self, "on_body_enter")



func bounce(vel):
	velocity = vel
	set_fixed_process(true)

func on_body_enter(body):
	if body.get_object_type() == Glb.ObjectTypes.Teo:
		body.pick(Glb.ObjectTypes.Bullet)
		queue_free()

func get_object_type(): return Glb.ObjectTypes.Pickable


func _fixed_process(delta):
	var pos = get_pos()
	set_pos(pos + velocity * delta)
	velocity = velocity.linear_interpolate(Vector2(), 0.8)

	if velocity == Vector2():
		get_node("area").set_enable_monitoring(true)
		set_fixed_process(false)