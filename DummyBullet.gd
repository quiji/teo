extends KinematicBody2D

var direction = Vector2()
var velocity = Vector2()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func shoot(dir):
	velocity = direction * 100
	set_fixed_process(true)


func _fixed_process(delta):

	move(velocity * delta)

	if is_colliding():
		var collider = get_collider()
		collider.hit()
		queue_free()