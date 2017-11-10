extends KinematicBody2D


var direction = Vector2(0, 1)

var velocity = Vector2()

var running = false

var bullet_factory = load("res://objects/bullet_base.tscn")
var hit_count = 0
var bullets = 10

func _ready():
	set_fixed_process(true)
	get_node("timer").connect("timeout", self, "on_timeout")

func _fixed_process(delta):
	pass


func hit(velocity, strength):
	hit_count += 1
	Glb.tell_HUD(Glb.HUDActions.Log, "Enemy Hit!!")

func pick(obj):
	bullets += 1

func get_object_type(): return Glb.ObjectTypes.Enemy

func on_timeout():
	var bullet = bullet_factory.instance()
	var target_direction = (get_node("../teo").get_pos() - get_pos()).normalized()
	
	bullet.set_pos(get_pos())
	get_parent().add_child(bullet)
	bullet.throw(target_direction, 0.5)
	bullets -= 1
	if bullets == 0:
		get_node("timer").stop()


