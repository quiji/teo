extends YSort

var bullet_factory = load("res://objects/bullet_base.tscn")
var shadow = load("res://objects/shadow.tscn")
var target_factory = load("res://gui/target_arrow.tscn")

var target_arrow = null

func _ready():


	var children = get_children()
	var i = 0
	while i < children.size():

		if children[i].has_method("is_shadow_enabled") and children[i].is_shadow_enabled():
			var sh = shadow.instance()
			add_child(sh)
			sh.follow_owner(children[i])
		i += 1

	target_arrow = target_factory.instance()
	add_child(target_arrow)

func throw_bullet(pos, direction, strength, is_teo):
	var bullet = bullet_factory.instance()
	var size = clamp(0.5 + (0.5 * strength), 0.5, 1)

	bullet.set_pos(pos)
	add_child(bullet)
	var sh = shadow.instance()
	add_child(sh)

	
	sh.follow_owner(bullet, size)
	bullet.throw(direction, strength, is_teo, size)
	

func start_polling_target(pos, direction): return target_arrow.poll_target(pos, direction)
func stop_polling_target(): target_arrow.stop_polling()