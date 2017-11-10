extends KinematicBody2D

var direction = Vector2(0, 1)
var side_dir = Vector2()
var velocity = Vector2()

var running = false
var charging = false
var aim_walk = false

# Dummy vars
var hit_count = 0
var bullets = 2
var bullet_factory = load("res://objects/bullet_base.tscn")


func _ready():
	# Configure Keyboard
	Controller.add_buttons(Glb.keyboard)
	Controller.merge_buttons(Glb.keyboard_merged_buttons)

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

	if i.Throw == Controller.INPUT.Just_Released and bullets > 0:
		var strength = Glb.tell_HUD(Glb.HUDActions.ThrowChargeBarEnd)
		get_node("target_arrow").stop_polling()
		get_node("camera_crew").back_to_actor()
		charging = false
		aim_walk = false
		bullets -= 1
		var bullet = bullet_factory.instance()
		
		bullet.set_pos(get_pos())
		get_parent().add_child(bullet)

		bullet.throw(direction, strength, false)
	

func get_direction(): return direction

func change_direction(dir):
	if not charging:
		if dir != Glb.Directions.NoDirection:
			direction = dir
			running = true
		else:
			running = false
	else:
		if dir != Glb.Directions.NoDirection:
			if Glb.is_diagonal(direction):
				if Glb.is_diagonal(dir):
					side_dir = dir
					aim_walk = true
			else:
				if not Glb.is_diagonal(dir):
					side_dir = dir
					aim_walk = true
		else:
			aim_walk = false

func _fixed_process(delta):
	process_input(Controller.check())

	if running:
		velocity = velocity.linear_interpolate(direction * Glb.TeoStats.speed,  Glb.TeoStats.acceleration)
	elif aim_walk:
		velocity = velocity.linear_interpolate(side_dir * Glb.TeoStats.aimwalk_speed,  Glb.TeoStats.acceleration)
	else:
		velocity = velocity.linear_interpolate(Vector2(),  Glb.TeoStats.acceleration)
	
	if velocity != Vector2():
		move(velocity * delta)


	get_node("sprite").set_rot(direction.angle())
	get_node("camera_crew").update_actor_pos(get_pos(), direction)


func hit():
	hit_count += 1
	Glb.tell_HUD(Glb.HUDActions.Log, "Teo Hit!!")

func pick(obj):
	bullets += 1

func get_object_type(): return Glb.ObjectTypes.Teo