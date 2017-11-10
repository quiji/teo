extends KinematicBody2D


enum GhostStates {
	Idle,
	Walk,
	Throw,
	PrepareNextThrow
}

var idle = {
	waiting = Glb.StandardGhostStats.idle_time
}

var walk = {
	time = Glb.StandardGhostStats.walk_time,
	direction = Glb.Directions.Down
}

var prepare_next_throw = {
	waiting = Glb.StandardGhostStats.prepare_throw_time
}

var current_state = GhostStates.Idle

var direction = Vector2(0, 1)
var velocity = Vector2()

var bullet_factory = load("res://objects/bullet_base.tscn")


func _ready():
	set_fixed_process(true)

func get_object_type(): return Glb.ObjectTypes.Ghost

func hit(dir, strength):
	Glb.tell_HUD(Glb.HUDActions.Log, "Ghost Hit!!")


func teo_spotted(target):

	return target.length_squared() <= Glb.StandardGhostStats.spot_distance and direction.dot(target) >= 0.2

func process_state(delta):
	var teos_pos = get_parent().get_node("teo").get_pos()
	var my_pos = get_pos()
	var target = teos_pos - my_pos
	var spotted = teo_spotted(target)

	if current_state == GhostStates.Throw:
		Glb.tell_HUD(Glb.HUDActions.Log, "Throw")
		var bullet = bullet_factory.instance()
		
		bullet.set_pos(get_pos())
		get_parent().add_child(bullet)

		bullet.throw(target.normalized(), Glb.StandardGhostStats.throw_strength)
		current_state = GhostStates.PrepareNextThrow
		return true
	

	if current_state == GhostStates.PrepareNextThrow and not spotted:
		current_state = GhostStates.Idle
	elif current_state == GhostStates.PrepareNextThrow:
		Glb.tell_HUD(Glb.HUDActions.Log, "PrepareNextThrow")
		if prepare_next_throw.waiting > 0:
			prepare_next_throw.waiting -= delta
		else:
			prepare_next_throw.waiting = Glb.StandardGhostStats.prepare_throw_time
			current_state = GhostStates.Throw
		return true

	if spotted:
		current_state = GhostStates.Throw
		direction = target.normalized()
		return true


	if current_state == GhostStates.Idle:
		Glb.tell_HUD(Glb.HUDActions.Log, "Idle")
		if idle.waiting > 0:
			idle.waiting -= delta
		else:
			current_state = GhostStates.Walk
			idle.waiting = Glb.StandardGhostStats.idle_time
		return true

	if current_state == GhostStates.Walk:
		Glb.tell_HUD(Glb.HUDActions.Log, "walk")
		if walk.time > 0:
			direction = walk.direction
			walk.time -= delta
		else:
			walk.direction = walk.direction * -1
			walk.time = Glb.StandardGhostStats.walk_time
			current_state = GhostStates.Idle


	

func _fixed_process(delta):

	process_state(delta)

	if current_state == GhostStates.Walk:
		velocity = velocity.linear_interpolate(direction * Glb.StandardGhostStats.walk_speed,  Glb.StandardGhostStats.acceleration)
	else:
		velocity = velocity.linear_interpolate(Vector2(),  Glb.StandardGhostStats.acceleration)
	
	move(velocity * delta)


