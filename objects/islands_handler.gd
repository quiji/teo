extends YSort

var sprite_handler = load("res://teo/sprite_handler.scn")
var dummy_teo = null
var velocity = Vector2()
var movement = Vector2()

func _ready():
	dummy_teo = sprite_handler.instance()
	dummy_teo.hide()
	add_child(dummy_teo)

	Glb.set_island_handler(self)



func move_objects(objects):
	get_parent().place_objects_on_playground(objects)

func show_dummy(pos, dir):
	dummy_teo.set_pos(pos)
	dummy_teo.set_opacity(1)
	dummy_teo.play_action("Fall", dir)
	dummy_teo.show()
	velocity = Vector2(0, 50)
	movement = dir * Glb.TeoStats.speed / 4
	set_fixed_process(true)


func _fixed_process(delta):

	if dummy_teo.get_opacity() < 0.2:
		set_fixed_process(false)
		dummy_teo.hide()
		Glb.tell_teo_to_respawn()
	dummy_teo.set_opacity(dummy_teo.get_opacity() - delta)
	velocity += Vector2(0, 9.8) * delta
	dummy_teo.set_pos(dummy_teo.get_pos() + (velocity + movement) * delta)