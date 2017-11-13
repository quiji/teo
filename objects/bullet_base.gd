extends KinematicBody2D

var height = 0
var max_height = 20

var gravity = 0
var fall_velocity = 0
var bullet_time = 0

var velocity = Vector2()

var speed = 0
var strength_level = 0
var is_bullet = true

func _ready():
	add_user_signal("moved")
	add_user_signal("freed")
	get_node("area").connect("body_enter", self, "on_body_enter")

func throw(dir, strength, is_teo, size=1):
	if not is_teo:
		set_layer_mask_bit(0, true)
		set_layer_mask_bit(1, false)
	else:
		set_layer_mask_bit(0, false)
		set_layer_mask_bit(1, true)
	
	height = max_height
	gravity = -2 * height / pow(Glb.get_bullet_fall_time(strength), 2.0)
	set_fixed_process(true)
	speed = Glb.get_bullet_speed(strength)
	velocity = dir * Glb.get_bullet_speed(strength)
	strength_level = strength 

	get_node("sprite_handler").set_scale(Vector2(size, size))


	get_node("sprite_handler").get_sprite().set_pos(Vector2(0, -height))
	bullet_time = Glb.get_bullet_time(strength)
	get_node("sprite_handler").add_animation_speed(strength + 0.5)
	

func get_object_type(): 
	if is_bullet:
		return Glb.ObjectTypes.Bullet
	else:
		return Glb.ObjectTypes.Pickable
		
func is_shadow_enabled(): return true
func get_shadow_offset(): return Vector2(1, 1)
func get_sprite_handler(): return get_node("sprite_handler")

func on_body_enter(body):
	if body.get_object_type() == Glb.ObjectTypes.Teo:
		body.pick(Glb.ObjectTypes.Bullet)
		queue_free()
	

func _fixed_process(delta):


	get_node("sprite_handler").get_sprite().set_pos(Vector2(0, -height))
	#var scale = height / max_height
	#get_node("shadow").set_scale(Vector2(scale, scale))

	if bullet_time <= 0:
		fall_velocity += gravity 
		height += fall_velocity * delta
	else:
		bullet_time -= delta

	move(velocity * delta)
	if get_travel().length_squared() > 0: emit_signal("moved", self)

	if height <= 0:
		set_fixed_process(false)
		velocity = Vector2()
		set_layer_mask_bit(0, false)
		set_layer_mask_bit(1, false)
		get_node("area").set_enable_monitoring(true)
		is_bullet = false
		emit_signal("freed", self)
		get_node("sprite_handler").pause()
	elif is_colliding():
		var collider = get_collider()
		if collider.get_object_type() == Glb.ObjectTypes.Teo or collider.get_object_type() == Glb.ObjectTypes.Ghost:
			collider.hit(velocity.normalized(), strength_level)
		velocity = get_collision_normal().reflect(velocity.normalized()) * speed * 0.5
		get_node("sprite_handler").play_backwards_from_spot()


