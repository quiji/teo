extends Node2D

var total_bullets = 0

var DummyBulletFactory = load("res://DummyBullet.tscn")

func _ready():

	get_node("Timer").connect("timeout", self, "on_timeout")



func on_timeout():
	var bullet = DummyBulletFactory.instance()
	var direction = (get_node("teo").get_pos() - get_node("evil_godot").get_pos()).normalized()
	
	bullet.set_pos(get_node("evil_godot").get_pos())
	add_child(bullet)
	get_node("log").update("bullet_vel", bullet.shoot(direction))

	total_bullets += 1

	get_node("log").update("bullet_direction", direction)
	get_node("log").update("total_bullets", total_bullets)
