extends Node2D

var shadow = null

func generate_shadow(sprite_handler, owners_offset):
	var spr = sprite_handler.get_sprite()
	shadow = Sprite.new()
	shadow.set_modulate("000000")
	shadow.set_opacity(0.3)
	

	shadow.set_pos(owners_offset)
	shadow.set_offset(Vector2(1, 0))
	shadow.set_texture(spr.get_texture())

	if spr.is_region():
		shadow.set_region(true)
		shadow.set_region_rect(spr.get_region_rect() )
	add_child(shadow)

func follow_owner(node):
	var offset = Vector2()
	if node.has_method("get_shadow_offset"):
		offset = node.get_shadow_offset()
	generate_shadow(node.get_sprite_handler(), offset)
	node.connect("moved", self, "on_owner_moved")

func on_owner_moved(owner):
	var region = owner.get_sprite_handler().get_sprite().get_region_rect()
	set_pos(owner.get_pos())
	
	shadow.set_region_rect(region)

	shadow.set_scale(Vector2( 1, 0.3))

