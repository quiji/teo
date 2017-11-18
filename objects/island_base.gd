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


func on_body_exit(fella):
	if fella.has_method("exit_island"):
		fella.exit_island()

func on_body_enter(fella):
	if fella.has_method("enter_island"):
		fella.enter_island()