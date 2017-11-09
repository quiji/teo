extends RigidBody2D

var height = 10
var max_height = 10
var fall_time = 5
var gravity = 0
var velocity = 0

var is_bullet = true

func _ready():
	gravity = -2 * height / pow(fall_time, 2.0)
	get_node("area").connect("body_enter", self, "on_body_enter")

func throw(dir, strength, enemy=true):
	if enemy:
		set_layer_mask_bit(0, true)
		set_layer_mask_bit(1, false)
	else:
		set_layer_mask_bit(0, false)
		set_layer_mask_bit(1, true)
	
	set_fixed_process(true)
	set_linear_velocity(dir * Glb.get_bullet_speed(strength))

func get_object_type(): 
	if is_bullet:
		return Glb.ObjectTypes.Bullet
	else:
		return Glb.ObjectTypes.Pickable
		

func on_body_enter(body):
	if body.get_object_type() == Glb.ObjectTypes.Teo:
		body.pick(Glb.ObjectTypes.Bullet)
		queue_free()
	

func _fixed_process(delta):


	get_node("shadow").set_pos(Vector2(0, height))
	var scale = height / max_height
	get_node("shadow").set_scale(Vector2(scale, scale))

	velocity += gravity 
	height += velocity * delta

	if height <= 0:
		set_fixed_process(false)
		get_node("shadow").hide()
		set_linear_velocity(Vector2())
		set_mode(MODE_STATIC)
		set_layer_mask_bit(0, false)
		set_layer_mask_bit(1, false)
		get_node("area").set_enable_monitoring(true)
		is_bullet = false



