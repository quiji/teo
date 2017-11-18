extends Node2D


func _ready():

	if has_node("walkable_area"):
		get_node("walkable_area").connect("body_exit", self, "on_body_exit")




func on_body_exit(fella):
	if fella.has_method("out_of_island"):
		fella.out_of_island()