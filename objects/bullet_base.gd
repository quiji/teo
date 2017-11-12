extends KinematicBody2D

var height = 10
var max_height = 10

var gravity = 0
var fall_velocity = 0

var velocity = Vector2()

var speed = 0
var strength_level = 0
var is_bullet = true

func _ready():
	get_node("area").connect("body_enter", self, "on_body_enter")

func throw(dir, strength, is_teo):
	if not is_teo:
		set_layer_mask_bit(0, true)
		set_layer_mask_bit(1, false)
	else:
		set_layer_mask_bit(0, false)
		set_layer_mask_bit(1, true)
	
	gravity = -2 * height / pow(Glb.get_buller_air_time(strength), 2.0)
	set_fixed_process(true)
	speed = Glb.get_bullet_speed(strength)
	velocity = dir * Glb.get_bullet_speed(strength)
	strength_level = strength 

	

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

	fall_velocity += gravity 
	height += fall_velocity * delta

	move(velocity * delta)


	if height <= 0:
		set_fixed_process(false)
		get_node("shadow").hide()
		velocity = Vector2()
		set_layer_mask_bit(0, false)
		set_layer_mask_bit(1, false)
		get_node("area").set_enable_monitoring(true)
		is_bullet = false
	elif is_colliding():
		var collider = get_collider()
		if collider.get_object_type() == Glb.ObjectTypes.Teo or collider.get_object_type() == Glb.ObjectTypes.Ghost:
			collider.hit(velocity.normalized(), strength_level)
		velocity = get_collision_normal().reflect(velocity.normalized()) * speed * 0.5


