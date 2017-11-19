extends Node2D


func _ready():

	if has_node("walkable_area"):
		get_node("walkable_area").connect("body_exit", self, "on_body_exit")
		get_node("walkable_area").connect("body_enter", self, "on_body_enter")

	var children = get_node("objects").get_children()
	var i = 0
	var my_pos = get_pos()
	while i < children.size():
		children[i].set_pos(my_pos + children[i].get_pos())
		get_node("objects").remove_child(children[i])
		i += 1
	get_parent().move_objects(children)

	process_grass_animations("grass_back_layer_tilemap")
	process_grass_animations("grass_top_layer_tilemap")


func on_body_exit(fella):
	if fella.has_method("exit_island"):
		fella.exit_island()

func on_body_enter(fella):
	if fella.has_method("enter_island"):
		fella.enter_island()


func process_grass_animations(name):
	var tileset = get_node(name).get_tileset()
	var tiles_ids = tileset.get_tiles_ids()
	var i = 0

	var anim = get_node("animation_player").get_animation("grass")

	while  i < tiles_ids.size():
		if tileset.tile_get_name(tiles_ids[i]) != 'center_grass':
			var track_id = anim.add_track(Animation.TYPE_VALUE)
			var base_rect = tileset.tile_get_region(tiles_ids[i])
			anim.track_set_path(track_id, name + ":tile_set:" + str(tiles_ids[i]) + "/region")
			anim.track_set_interpolation_type(track_id, Animation.INTERPOLATION_NEAREST)

			anim.track_insert_key(track_id, 0, base_rect, Animation.UPDATE_DISCRETE)
			
			base_rect.pos.x += 16
			anim.track_insert_key(track_id, 0.1, base_rect, Animation.UPDATE_DISCRETE)
			base_rect.pos.x += 16
			anim.track_insert_key(track_id, 0.2, base_rect, Animation.UPDATE_DISCRETE)
			base_rect.pos.x += 16
			anim.track_insert_key(track_id, 0.3, base_rect, Animation.UPDATE_DISCRETE)
			base_rect.pos.x += 16
			anim.track_insert_key(track_id, 0.4, base_rect, Animation.UPDATE_DISCRETE)
		i += 1