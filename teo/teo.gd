extends KinematicBody2D

var direction = Vector2(0, 1)
var target = Vector2()
var side_dir = Vector2()
var velocity = Vector2()

var running = false
var charging = false
var aim_walk = false
var aim_walk_sides = false
var react_wait_delta = 0

var bullets = 20


func _ready():
	# Configure Keyboard
	Controller.add_buttons(Glb.keyboard)
	Controller.merge_buttons(Glb.keyboard_merged_buttons)

	add_user_signal("moved")
	set_fixed_process(true)

func process_input(i):

	if i.UpLeft == Controller.INPUT.Pressed: 
		change_direction(Glb.Directions.UpLeft)
	elif i.UpRight == Controller.INPUT.Pressed: 
		change_direction(Glb.Directions.UpRight)
	elif i.DownLeft == Controller.INPUT.Pressed: 
		change_direction(Glb.Directions.DownLeft)
	elif i.DownRight == Controller.INPUT.Pressed: 
		change_direction(Glb.Directions.DownRight)
	elif i.Left == Controller.INPUT.Pressed: 
		change_direction(Glb.Directions.Left)
	elif i.Right == Controller.INPUT.Pressed: 
		change_direction(Glb.Directions.Right)
	elif i.Up == Controller.INPUT.Pressed: 
		change_direction(Glb.Directions.Up)
	elif i.Down == Controller.INPUT.Pressed: 
		change_direction(Glb.Directions.Down)
	elif Controller.group_or(i, Glb.MovementGroup, Controller.INPUT.Just_Released): 
		change_direction(Glb.Directions.NoDirection)


	if i.Throw == Controller.INPUT.Just_Pressed and bullets > 0:
		Glb.tell_HUD(Glb.HUDActions.ThrowChargeBarStart)
		target = get_parent().start_polling_target(get_pos(), direction)
		get_parent().camera_snipe_ahead(target)
		charging = true
		running = false

		get_node("sprite_handler").play_action("IdleThrow", direction)

	if i.Throw == Controller.INPUT.Just_Released and bullets > 0 and charging:
		var strength = Glb.tell_HUD(Glb.HUDActions.ThrowChargeBarEnd)
		get_parent().stop_polling_target()
		get_parent().camera_back_to_actor()
		charging = false
		aim_walk = false
		bullets -= 1
		get_parent().throw_bullet(get_pos(), side_dir, strength, true)
	

func get_direction(): return direction

func change_direction(dir):
	if not charging:
		if dir != Glb.Directions.NoDirection:
			direction = dir
			running = true
			get_node("sprite_handler").play_action("Run", direction)
		else:
			running = false
			get_node("sprite_handler").play_action("Idle", direction)
	else:
		if dir != Glb.Directions.NoDirection:
			aim_walk = true
			direction = dir
			
			var target_dir = (target - get_pos()).normalized()
			var closest_dir = null

			get_node("debug_target").set_direction(target_dir)
			closest_dir = Glb.find_closest_direction(target_dir)

			if closest_dir != null: 
				side_dir = closest_dir


			if direction == side_dir:
				get_node("sprite_handler").play_action("FrontThrow", side_dir, false)
				aim_walk_sides = false
			elif direction == -side_dir:
				get_node("sprite_handler").play_action("FrontThrow", side_dir, true)
				aim_walk_sides = false
			elif direction == Vector2(side_dir.y, -side_dir.x):
				get_node("sprite_handler").play_action("SideThrow", side_dir, false)
				aim_walk_sides = true
			else:
				get_node("sprite_handler").play_action("SideThrow", side_dir, true)
				aim_walk_sides = true

		else:
			direction = side_dir
			aim_walk = false
			get_node("sprite_handler").play_action("IdleThrow", direction)

func _fixed_process(delta):
	if react_wait_delta <= 0:
		process_input(Controller.check())
	else:
		react_wait_delta -= delta

	if running:
		var top_velocity = direction * Glb.TeoStats.speed
		if velocity == top_velocity:
			velocity = velocity.linear_interpolate(top_velocity / 2,  Glb.TeoStats.acceleration)
		else:
			velocity = velocity.linear_interpolate(top_velocity,  Glb.TeoStats.acceleration)
	elif aim_walk and aim_walk_sides:
		velocity = velocity.linear_interpolate(direction * Glb.TeoStats.aimwalk_speed,  Glb.TeoStats.acceleration)
	elif aim_walk:
		velocity = velocity.linear_interpolate(direction * Glb.TeoStats.aimwalk_speed_backwards,  Glb.TeoStats.acceleration)
	else:
		velocity = velocity.linear_interpolate(Vector2(),  Glb.TeoStats.acceleration)
	
	if velocity != Vector2():
		move(velocity * delta)
		if get_travel().length_squared() > 0: emit_signal("moved", self)


	# Some debugging
	get_node("debug_direction").set_direction(direction)
	get_node("debug_side_direction").set_direction(side_dir)


func hit(dir, strength):
	aim_walk = false
	running = false 
	charging = false
	Glb.tell_HUD(Glb.HUDActions.ThrowChargeBarEnd)
	get_parent().stop_polling_target()
	get_parent().camera_back_to_actor()

	velocity = -dir * Glb.get_bullet_throwback(strength)
	react_wait_delta = Glb.TeoStats.react_delay
	

func pick(obj):
	bullets += 1

func get_object_type(): return Glb.ObjectTypes.Teo
func is_shadow_enabled(): return true
func get_shadow_offset(): return Vector2(0, -5)
func get_sprite_handler(): return get_node("sprite_handler")


func react(action):
	if action == "Step":
		velocity = direction * Glb.TeoStats.speed / 2