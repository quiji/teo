extends YSort

var bullet_factory = load("res://objects/bullet_base.tscn")
var shadow = load("res://objects/shadow.tscn")

func _ready():


	var children = get_children()
	var i = 0
	while i < children.size():

		if children[i].has_method("is_shadow_enabled") and children[i].is_shadow_enabled():
			var sh = shadow.instance()
			add_child(sh)
			sh.follow_owner(children[i])
		i += 1


func throw_bullet(pos, direction, strength, is_teo):
	var bullet = bullet_factory.instance()

	bullet.set_pos(pos)
	add_child(bullet)
	# Spawn shadow!!!!

	bullet.throw(direction, strength, is_teo)