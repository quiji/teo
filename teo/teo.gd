extends KinematicBody2D

var direction = Vector2(0, 1)

var velocity = Vector2()

var running = false



# Dummy vars
var hit_count = 0
var bullets = 0
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
	if i.Throw == Controller.INPUT.Just_Released and bullets > 0:
		var strength = Glb.tell_HUD(Glb.HUDActions.ThrowChargeBarEnd)
		bullets -= 1
		var bullet = bullet_factory.instance()
		
		bullet.set_pos(get_pos())
		get_parent().add_child(bullet)
		bullet.throw(direction, strength, false)
	

func change_direction(dir):
	if dir != Glb.Directions.NoDirection:
		direction = dir
		running = true
	else:
		running = false

func _fixed_process(delta):
	process_input(Controller.check())

	if running:
		velocity = velocity.linear_interpolate(direction * Glb.TeoStats.speed,  Glb.TeoStats.acceleration)
	else:
		velocity = velocity.linear_interpolate(Vector2(),  Glb.TeoStats.acceleration)
	
	if velocity != Vector2():
		move(velocity * delta)


	get_node("sprite").set_rot(direction.angle())


func hit():
	hit_count += 1
	get_node("log").update("hit_count", hit_count)

func pick(obj):
	bullets += 1
	get_node("log").update("bullets", bullets)

func get_object_type(): return Glb.ObjectTypes.Teo