extends Node2D

var direction = Vector2()

var owner = null

func _ready():
	add_user_signal("moved")
	hide()

func poll_target(own):
	owner = own
	position()
	show()
	set_fixed_process(true)

func stop_polling():
	hide()
	set_fixed_process(false)

func position():
	if owner != null:
		var owners_pos = owner.get_pos()
		var direction = (get_global_mouse_pos() - owners_pos).normalized()
		set_pos(owners_pos + direction * 100)
		emit_signal("moved", self)

func _fixed_process(delta):
	position()