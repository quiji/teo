extends Node2D

var direction = Vector2()
var col = Color(0, 0, 0)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _draw():

	draw_line(Vector2(), direction * 20, col, 1)


func set_direction(dir, c):
	col = c
	direction = dir
	update()