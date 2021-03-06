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
			if children[i].get_object_type() == Glb.ObjectTypes.Bullet:
				children[i].spawn_as_pickable()
		i += 1

	target_arrow = target_factory.instance()
	add_child(target_arrow)
	get_node("camera_crew").set_actor(get_node("teo"))

func throw_bullet(throw_meta):
	var bullet = bullet_factory.instance()

	bullet.set_pos(throw_meta.initial_pos)
	add_child(bullet)
	var sh = shadow.instance()
	add_child(sh)

	var size = bullet.throw(throw_meta)
	sh.follow_owner(bullet, size)
	
	

func start_polling_target(owner): 
	get_node("camera_crew").change_actor(target_arrow)
	return target_arrow.poll_target(owner)

func stop_polling_target(): 
	target_arrow.stop_polling()
	get_node("camera_crew").change_actor(get_node("teo"))

func add_objects(objects):
	var i = 0
	while i < objects.size():
		add_child(objects[i])
		i += 1

func move_to_fallers(obj):
	remove_child(obj)
	get_parent().place_object_on_fallers(obj)

func spawn_warp_stone(pos):
	var bullet = bullet_factory.instance()
	
	bullet.rock_type = Glb.RockTypes.Warp
	bullet.set_pos(pos)
	add_child(bullet)
	var sh = shadow.instance()
	add_child(sh)
	sh.follow_owner(bullet)
	bullet.spawn_as_pickable()
	