extends Node2D

var direction = Vector2()


func _ready():
	hide()

func poll_target(pos, direction):
	var target = pos + direction * 60
	set_pos(target)
	show()
	return get_pos()

func stop_polling():
	hide()
