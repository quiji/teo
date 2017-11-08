extends CanvasLayer
const LABEL_SEPARATOR = 5

var dictionaries = {}
var Spaces = {
	left = [],
	left_current = 0,
	right = [],
	right_current = 0
}

onready var screen_size = OS.get_window_size()

func _ready():
	set_process_input(true)


func _input(event):
	if event.type == InputEvent.KEY:
		if event.scancode == KEY_F1 && event.pressed == false:
			move_next("left")
		if event.scancode == KEY_F2 && event.pressed == false:
			move_next("right")


func move_next(side):
	if Spaces[side].size() == 0: return null

	if Spaces[side + "_current"] == Spaces[side].size():
		Spaces[side + "_current"] = 0
		Spaces[side][0].get_meta("Logger").show_points()
		Spaces[side][0].show()
	else:
		Spaces[side][Spaces[side + "_current"]].hide()
		Spaces[side][0].get_meta("Logger").hide_points()
		Spaces[side + "_current"] += 1
		if Spaces[side + "_current"] < Spaces[side].size():
			Spaces[side][Spaces[side + "_current"]].show()
			Spaces[side][0].get_meta("Logger").show_points()

func add_to(side, node, log_size):
	Spaces[side].push_front(node)

	if Spaces[side].size() > 1: 
		Spaces[side][1].hide()
	node.set_meta("logger_position", side)
	node.set_meta("log_size", log_size)
	return Spaces[side].size()

func get_label(type, log_size):
	if log_size == 0: return get_node(type + "Nn").duplicate()
	elif log_size == 1: return get_node(type + "Smll").duplicate()
	elif log_size == 2: return get_node(type + "Mdm").duplicate()
	elif log_size == 3: return get_node(type + "Lrg").duplicate()
	return get_node(type + "Bg").duplicate()

func create_log_space(owner, logger, col, location, log_size):
	var node = Node2D.new()
	node.set_meta("Logger", logger)
	add_child(node)
	var page = 0
	if location == 0:
		page = add_to("left", node, log_size)
	else:
		page = add_to("right", node, log_size)
	
	var lbl = get_label("TitleBase", log_size)
	lbl.set_name("SpaceTitle")
	node.add_child(lbl)
	
	lbl.set("custom_colors/font_color", col)
	lbl.hide()


	lbl.set_text( String(page) + ": " + owner.get_name() + " (" + owner.get_type() + ") ")	

	return node.get_name()

func has_no_label_for(LogSpace, name): return !get_node(LogSpace).has_node(name)
func has_no_label_for_dict(LogSpace, name): return !dictionaries.has(name)

func generate_label(LogSpace, name):
	var space = get_node(LogSpace)
	var lbl = get_label("LogBase", space.get_meta("log_size"))
	lbl.set_name(name)
	space.add_child(lbl)

func generate_dict_label(LogSpace, name, variable):
	dictionaries[name] = true

	for i in variable:
		generate_label(LogSpace, name + "__" + i)

func update_label(LogSpace, name, value, col):
	var space = get_node(LogSpace)
	
	if typeof(value) == TYPE_DICTIONARY:
		for i in value:
			space.get_node(name + "__" + i).set_text(name + "[" + i + "]: " + convert_value(value[i]))
			space.get_node(name + "__" + i).set("custom_colors/font_color", col)
	else:
		space.get_node(name).set_text(name + ": " + convert_value(value))
		space.get_node(name).set("custom_colors/font_color", col)
	
	var children = space.get_children()
	var i = 0
	var total_size = 0

	while i < space.get_child_count():
		if not children[i].is_visible():
			children[i].show()
		if space.get_meta("logger_position") == "left":
			children[i].set_pos(Vector2(LABEL_SEPARATOR, total_size))
		else:
			var size = children[i].get("rect/size")
			children[i].set_pos(Vector2(screen_size.x - size.x - LABEL_SEPARATOR, total_size))
		total_size += LABEL_SEPARATOR + children[i].get_combined_minimum_size().y
		i += 1

func convert_value(val):
	if val == null:
		return 'Null'
	elif typeof(val) == TYPE_OBJECT:
		return val.get_type() + ":" + String(val.get_instance_ID())
	else:
		return String(val)


