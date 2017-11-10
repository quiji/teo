extends TextureProgress

var step = 1

const INITIAL_VALUE = 18
const STEP2 = 40
const STEP3 = 68
const FINAL_VALUE = 100

func _ready():
	get_node("timer").connect("timeout", self, "on_timeout")


func start_count():
	step = 1
	get_node("timer").start()
	show()
	set_value(INITIAL_VALUE)
	return true

func end_count(): 
	hide()
	if step == 1:
		return 0
	elif step == 2:
		return 0.2
	elif step == 3:
		return 0.4
	else:
		return 0.7

func on_timeout():
	step += 1
	if step == 2:
		set_value(STEP2)
	elif step == 3:
		set_value(STEP3)
	elif step == 4:
		set_value(FINAL_VALUE)
		get_node("timer").stop()

