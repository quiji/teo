extends KinematicBody2D

var direction = Vector2(0, 1)
var target = Vector2()
var velocity = Vector2()

var running = false
var charging = false
var aim_walk = false
var aim_walk_sides = false
var movement_blocked = false
var react_wait_delta = 0

var is_idle = true
var cant_fall = false


var side_dir = Vector2()
var target_dir = Vector2()

var outside_island = false

var respawn_point = Vector2()

var throw_meta = {
	direction = Vector2(),
	strength = 0,
	initial_pos = Vector2(),
	rock_type = Glb.RockTypes.None,
	owner = self
}

var satchel = []

func _ready():
	# Configure Keyboard
	Controller.add_buttons(Glb.keyboard)
	Controller.merge_buttons(Glb.keyboard_merged_buttons)

	# Moved is not used by anyone right now. Leaving here or future use... or future removal.
	add_user_signal("moved")
	set_fixed_process(true)

	Glb.set_teo(self)
	respawn_point = get_pos()

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
	else:
		change_direction(Glb.Directions.NoDirection)


	if i.SwapRock == Controller.INPUT.Just_Pressed and satchel.size() > 1:
		var last = satchel.back()
		satchel.pop_back()
		var next = satchel.back()
		satchel.pop_back()
		satchel.push_back(last)
		satchel.push_back(next)
		Glb.tell_HUD(Glb.HUDActions.SwapRock)

	if i.Throw == Controller.INPUT.Just_Pressed and satchel.size() > 0:
		is_idle = false
		Glb.tell_HUD(Glb.HUDActions.ThrowChargeBarStart)
		Glb.tell_HUD(Glb.HUDActions.HoldRock)
		get_parent().start_polling_target(self)
		charging = true
		running = false

		get_node("sprite_handler").play_action("IdleThrow", direction)

	if charging:
		target = get_global_mouse_pos()
	

	if i.Throw == Controller.INPUT.Just_Released and satchel.size() > 0 and charging:
		
		get_parent().stop_polling_target()
		charging = false
		aim_walk = false
		is_idle = false
		movement_blocked = true
		get_node("sprite_handler").play_action("Throw", side_dir)
		throw_meta.strength =  Glb.tell_HUD(Glb.HUDActions.ThrowChargeBarEnd)
		throw_meta.direction = target_dir
		Glb.tell_HUD(Glb.HUDActions.PopRock)
		

	

func get_direction(): return direction

func finished_animation(action):
	if action == "Throw" and is_idle:
		get_node("sprite_handler").play_action("Idle", direction)

func change_direction(dir):
	is_idle = false
	if not charging:
		if dir != Glb.Directions.NoDirection:
			direction = dir
			running = true
			get_node("sprite_handler").play_action("Run", direction)
		else:
			running = false
			get_node("sprite_handler").play_action("Idle", direction)
			is_idle = true
	else:
		target_dir = (target - get_pos()).normalized()
		var closest_dir = Glb.find_closest_direction(target_dir)
		get_node("debug_target").set_direction(target_dir)

		if closest_dir != null: 
			side_dir = closest_dir

		if dir != Glb.Directions.NoDirection:
			aim_walk = true
			direction = dir

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
	if react_wait_delta <= 0 and not movement_blocked:
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
	movement_blocked = false
	Glb.tell_HUD(Glb.HUDActions.ThrowChargeBarEnd)
	get_parent().stop_polling_target()
	get_parent().camera_back_to_actor()

	velocity = -dir * Glb.get_bullet_throwback(strength)
	react_wait_delta = Glb.TeoStats.react_delay
	

func pick(rock_type):
	if satchel.size() < 2:
		satchel.push_back(rock_type)
		Glb.tell_HUD(Glb.HUDActions.PushRock, rock_type)
		return true
	return false

func get_object_type(): return Glb.ObjectTypes.Teo
func is_shadow_enabled(): return true
func get_shadow_offset(): return Vector2(0, -5)
func get_sprite_handler(): return get_node("sprite_handler")
func is_over_island(): return not outside_island

func react(action, var1=null):
	
	if action == "Step" and running:
		velocity = direction * Glb.TeoStats.speed / 2
	elif action == "Step" and aim_walk_sides:
		velocity = direction * Glb.TeoStats.aimwalk_speed / 2
	elif action == "Throw":
		throw_meta.initial_pos = get_node("sprite_handler").get_pos() + var1 + get_pos()
		throw_meta.rock_type = satchel.back()
		satchel.pop_back()
		get_parent().throw_bullet(throw_meta)
		movement_blocked = false
	elif action == "Teleport":
		cant_fall = true
		set_pos(var1)
		emit_signal("moved", self)
		

func exit_island():
	if not cant_fall:
		get_node("sprite_handler").play_action("Fall", direction)
		outside_island = true
		set_fixed_process(false)
		emit_signal("moved", self)
		Glb.ask_island_for_dummy(get_pos() + get_node("sprite_handler").get_pos(), direction)
		hide()
	else:
		cant_fall = false

func respawn():
	set_pos(respawn_point)
	outside_island = false
	set_fixed_process(true)
	show()
	get_node("sprite_handler").play_action("Idle", direction)
	emit_signal("moved", self)
