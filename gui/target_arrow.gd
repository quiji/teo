extends Node2D

var direction = Vector2()


func poll_target():
	direction = get_parent().get_direction()
	set_pos(direction * 60)
	show()

func stop_polling():
	hide()
