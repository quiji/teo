extends Node2D

var total_bullets = 0

var DummyBulletFactory = load("res://DummyBullet.tscn")

func _ready():

	get_node("Timer").connect("timeout", self, "on_timeout")



func on_timeout():
	var bullet = DummyBulletFactory.instance()
	var direction = get_node("evil_godot").get_pos() - get_node("teo").get_pos()
	bullet.set_pos(get_node("evil_godot").get_pos())
	add_child(bullet)
	bullet.shoot(direction.normalized())

	total_bullets += 1

	get_node("log").update("total_bullets", total_bullets)
