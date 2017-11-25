extends Container

var rocks = []
var pushing = false
var pending = null

func _ready():
	get_node("rock_anims_0").connect("finished", self, "on_finished_rock0")
	get_node("rock_anims_1").connect("finished", self, "on_finished_rock1")
	
func push_rock(rock_type):
	rocks.push_back(rock_type)
	get_node("rock_" + str(rocks.size() - 1)).play_rock_type(rock_type)
	play_current("Push")

func on_finished_rock0():
	if get_node("rock_anims_0").get_current_animation() == "Push":
		get_node("sprite_handler").play("Fill")
		get_node("rock_0").pause()
	elif get_node("rock_anims_0").get_current_animation() == "Swap_1":
		get_node("rock_0").play_rock_type(rocks[1])
		get_node("rock_1").play_rock_type(rocks[0])
		var temp = rocks[1]
		rocks[1] = rocks[0]
		rocks[0] = temp
		get_node("rock_anims_0").play("Swap_2")
	elif get_node("rock_anims_0").get_current_animation() == "Swap_2":
		get_node("rock_0").pause()
		get_node("rock_1").pause()

func on_finished_rock1():
	if get_node("rock_anims_1").get_current_animation() == "Push":
		get_node("sprite_handler").play("Fill")
		get_node("rock_1").pause()
	elif get_node("rock_anims_0").get_current_animation() == "Swap_1":
		get_node("rock_0").play_rock_type(rocks[1])
		get_node("rock_1").play_rock_type(rocks[0])
		var temp = rocks[1]
		rocks[1] = rocks[0]
		rocks[0] = temp
		get_node("rock_anims_0").play("Swap_2")
	elif get_node("rock_anims_0").get_current_animation() == "Swap_2":
		get_node("rock_0").pause()
		get_node("rock_1").pause()

func hold_rock():
	get_node("rock_" + str(rocks.size() - 1)).play_rock_type(rocks.back())
	play_current("Hold")

func pop_rock():
	play_current("Throw")
	rocks.pop_back()

func cancel_rock():
	get_node("rock_" + str(rocks.size() - 1)).pause()
	play_current("Hold", true)

func swap_rock():
	get_node("rock_anims_0").play("Swap_1")


func play_current(anim, backwards = false):
	if backwards:
		get_node("rock_anims_" + str(rocks.size() - 1)).play_backwards(anim)
	else:
		get_node("rock_anims_" + str(rocks.size() - 1)).play(anim)