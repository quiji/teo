extends KinematicBody2D

var direction = Vector2()
var velocity = Vector2()

var ObjectFactory = load("res://dummy_pickable.tscn")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func shoot(dir, enemy=true):
	if enemy:
		set_layer_mask_bit(0, true)
		set_layer_mask_bit(1, false)
	else:
		set_layer_mask_bit(0, false)
		set_layer_mask_bit(1, true)
	velocity = dir * 500
	set_fixed_process(true)
	return velocity

func get_object_type(): return Glb.ObjectTypes.Bullet

func _fixed_process(delta):

	move(velocity * delta)

	if is_colliding():
		if get_collider().get_object_type() == Glb.ObjectTypes.Teo:
			get_collider().hit()
		var obj = ObjectFactory.instance()
		obj.set_pos(get_pos())
		get_parent().add_child(obj)
		queue_free()