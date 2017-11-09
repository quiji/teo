extends Node2D

var direction = Vector2()
var target = Vector2()
var center_angle = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func poll_target():
	direction = get_parent().get_direction()
	center_angle = direction.angle()
	target = direction
	show()
	set_fixed_process(true)

func move_arrow(vars):
	if vars == Glb.Directions.Left:
		pass
	elif vars == Glb.Directions.Right:
		pass
	elif vars == Glb.Directions.Up:
		pass
	elif vars == Glb.Directions.Down:
		pass
	return true

func stop_polling():
	hide()
	set_fixed_process(false)
	return target 


func _fixed_process(delta):
	set_pos(target * 50)
