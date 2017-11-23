extends KinematicBody2D

export (int, "None", "Regular", "Warp", "Shield", "EnemyRegular") var rock_type = Glb.RockTypes.None

var height = 0
var max_height = 20

var gravity = 0
var fall_velocity = 0
var bullet_time = 0

var velocity = Vector2()
var top_velocity = null

var speed = 0
var strength_level = 0
var is_bullet = true

var outside_island = true
var reached_ground_emitted = false

var owner = null

var i_am_initialized = false
var spawned_as_pickable = false

func _ready():
	if not i_am_initialized:
		i_am_initialized = true
		add_user_signal("moved")
		add_user_signal("reached_ground")
		get_node("area").connect("body_enter", self, "on_body_enter")
		get_node("tween").connect("tween_complete", self, "on_tween_complete")
	else:
		get_node("sprite_handler").restore_animation_spot(0.01)

func throw(throw_meta):
	rock_type = throw_meta.rock_type
	owner = throw_meta.owner
	if rock_type == Glb.EnemyRegular:
		set_layer_mask_bit(0, true)
		set_layer_mask_bit(1, false)
	else:
		set_layer_mask_bit(0, false)
		set_layer_mask_bit(1, true)
	
	var size = clamp(0.5 + (0.5 * throw_meta.strength), 0.5, 1)
	height = max_height
	gravity = -2 * height / pow(Glb.get_bullet_fall_time(throw_meta.strength), 2.0)
	set_fixed_process(true)
	speed = Glb.get_bullet_speed(throw_meta.strength)
	velocity = throw_meta.direction * Glb.get_bullet_speed(throw_meta.strength)
	strength_level = throw_meta.strength 

	get_node("sprite_handler").scale_sprite(Vector2(size, size))
	get_node("sprite_handler").play_rock_type(rock_type)

	get_node("sprite_handler").get_sprite().set_pos(Vector2(0, -height))
	bullet_time = Glb.get_bullet_time(throw_meta.strength)
	get_node("sprite_handler").add_animation_speed(throw_meta.strength + 0.5)
	var pos = get_pos()
	set_pos(Vector2(pos.x, pos.y + height))
	
	return size

func get_object_type(): 
	if is_bullet:
		return Glb.ObjectTypes.Bullet
	else:
		return Glb.ObjectTypes.Pickable
		
func is_shadow_enabled(): return true
func get_shadow_offset(): return Vector2(1, 1)
func get_sprite_handler(): return get_node("sprite_handler")
func exit_island(): outside_island = true
func enter_island(): outside_island = false
func is_over_island(): return not outside_island


func on_body_enter(body):
	if body.get_object_type() == Glb.ObjectTypes.Teo:
		if spawned_as_pickable:
			emit_signal("reached_ground", self)
		body.pick(Glb.ObjectTypes.Bullet)
		queue_free()

func on_tween_complete(object, key):
	if object == self and key == "transform/scale":
		queue_free()

func spawn_as_pickable():
	get_node("sprite_handler").play_rock_type(rock_type)
	outside_island = false
	if rock_type == Glb.RockTypes.Warp:
		height = 20
		get_node("sprite_handler").slow(0.6)
		get_node("sprite_handler").get_sprite().set_pos(Vector2(0, -height))
		get_node("collision").set_pos(Vector2(0, -height))
		get_node("animation_player").play("floating")
		emit_signal("moved", self)
	else:
		get_node("sprite_handler").pause()
	set_fixed_process(false)
	velocity = Vector2()
	set_layer_mask_bit(0, false)
	set_layer_mask_bit(1, false)
	get_node("area").set_enable_monitoring(true)
	is_bullet = false
	spawned_as_pickable = true



func _fixed_process(delta):

	get_node("sprite_handler").get_sprite().set_pos(Vector2(0, -height))
	get_node("collision").set_pos(Vector2(0, -height))

	if bullet_time <= 0:
		fall_velocity += gravity 
		height += fall_velocity * delta
	else:
		bullet_time -= delta

	if top_velocity != null:
		velocity = velocity.linear_interpolate(top_velocity, 0.08)
	move(velocity * delta)
	if get_travel().length_squared() > 0: emit_signal("moved", self)

	
	if height <= 0 and outside_island: 
		fall_velocity = fall_velocity / 2
		if not reached_ground_emitted:
			top_velocity = velocity.normalized() * speed / 2.5 + Vector2(0, 1) * speed * 1.2
			reached_ground_emitted = true
			emit_signal("reached_ground", self)
			get_node("sprite_handler").store_animation_spot()
			get_parent().move_to_fallers(self)
	elif height <= 0:
		set_fixed_process(false)
		velocity = Vector2()
		set_layer_mask_bit(0, false)
		set_layer_mask_bit(1, false)
		get_node("area").set_enable_monitoring(true)
		is_bullet = false
		if not reached_ground_emitted:
			reached_ground_emitted = true
			emit_signal("reached_ground", self)
		get_node("sprite_handler").pause()
		if rock_type == Glb.RockTypes.Warp:
			owner.react("Teleport", get_pos())

	elif is_colliding():
		var collider = get_collider()
		if collider.get_object_type() == Glb.ObjectTypes.Teo or collider.get_object_type() == Glb.ObjectTypes.Ghost:
			collider.hit(velocity.normalized(), strength_level)
		velocity = get_collision_normal().reflect(velocity.normalized()) * speed * 0.5
		get_node("sprite_handler").play_backwards_from_spot()


func free_fall():
	set_layer_mask_bit(0, false)
	set_collision_mask_bit(0, false)
	set_layer_mask_bit(1, false)
	set_collision_mask_bit(1, false)

	is_bullet = false
	get_node("tween").interpolate_property(self, "transform/scale", Vector2(1, 1), Vector2(0.2, 0.2), 1, Tween.TRANS_CUBIC, Tween.EASE_IN)
	get_node("tween").start()
