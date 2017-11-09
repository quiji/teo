extends KinematicBody2D


var direction = Vector2(0, 1)

var velocity = Vector2()

var running = false

var DummyBulletFactory = load("res://DummyBullet.tscn")
var hit_count = 0
var bullets = 0

func _ready():
	set_fixed_process(true)
	get_node("timer").connect("timeout", self, "on_timeout")

func _fixed_process(delta):

	pass


func hit():
	hit_count += 1
	get_node("log").update("hit_count", hit_count)

func pick(obj):
	bullets += 1

func get_object_type(): return Glb.ObjectTypes.Enemy

func on_timeout():
	var bullet = DummyBulletFactory.instance()
	var target_direction = (get_node("../teo").get_pos() - get_pos()).normalized()
	
	bullet.set_pos(get_pos())
	get_parent().add_child(bullet)
	bullet.shoot(target_direction)


	
