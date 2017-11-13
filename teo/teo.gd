extends KinematicBody2D

var direction = Vector2(0, 1)
var side_dir = Vector2()
var velocity = Vector2()

var running = false
var charging = false
var aim_walk = false
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
		get_node("target_arrow").poll_target()
		get_node("camera_crew").snipe_ahead()
		charging = true
		running = false
		get_node("sprite_handler").play_action("IdleThrow", direction)

	if i.Throw == Controller.INPUT.Just_Released and bullets > 0 and charging:
		var strength = Glb.tell_HUD(Glb.HUDActions.ThrowChargeBarEnd)
		get_node("target_arrow").stop_polling()
		get_node("camera_crew").back_to_actor()
		charging = false
		aim_walk = false
		bullets -= 1
		get_parent().throw_bullet(get_pos(), direction, strength, true)
	

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
			if Glb.is_diagonal(direction):
				if Glb.is_diagonal(dir):
					side_dir = dir
					aim_walk = true
					get_node("sprite_handler").play_action("SideThrow", direction)
			else:
				if not Glb.is_diagonal(dir):
					side_dir = dir
					aim_walk = true
					if direction == side_dir:
						get_node("sprite_handler").play_action("FrontThrow", direction)
					elif direction == -side_dir:
						get_node("sprite_handler").play_action("FrontThrow", direction, true)
					elif direction == Vector2(side_dir.y, side_dir.x):
						get_node("sprite_handler").play_action("SideThrow", direction, false)
					else:
						get_node("sprite_handler").play_action("SideThrow", direction, true)
		else:
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
	elif aim_walk:
		velocity = velocity.linear_interpolate(side_dir * Glb.TeoStats.aimwalk_speed,  Glb.TeoStats.acceleration)
	else:
		velocity = velocity.linear_interpolate(Vector2(),  Glb.TeoStats.acceleration)
	
	if velocity != Vector2():
		move(velocity * delta)
		if get_travel().length_squared() > 0: emit_signal("moved", self)


	get_node("camera_crew").update_actor_pos(get_pos(), direction)


func hit(dir, strength):
	aim_walk = false
	running = false 
	charging = false
	Glb.tell_HUD(Glb.HUDActions.ThrowChargeBarEnd)
	get_node("target_arrow").stop_polling()
	get_node("camera_crew").back_to_actor()

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