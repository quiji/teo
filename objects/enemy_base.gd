extends KinematicBody2D


enum GhostStates {
	Idle,
	
}

var direction = Vector2(0, 1)
var velocity = Vector2()

var moving = false
var state = GhostStates.Idle
func _ready():
	set_fixed_process(true)

func get_object_type(): return Glb.ObjectTypes.Ghost

func hit(dir, strength):
	Glb.tell_HUD(Glb.HUDActions.Log, "Ghost Hit!!")
	

func _fixed_process(delta):

	if moving:
		velocity = velocity.linear_interpolate(direction * Glb.StandardGhostStats.speed,  Glb.StandardGhostStats.acceleration)
	else:
		velocity = velocity.linear_interpolate(Vector2(),  Glb.StandardGhostStats.acceleration)
	
	move(velocity * delta)

