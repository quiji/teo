extends Node2D

var current_action = ""
var prev_anim = ""
var prev_frame = 0.0
var stored_frame = 0

func _ready():
	if get_node("AnimationPlayer").has_animation("Down-Idle"):
		get_node("AnimationPlayer").play("Down-Idle")
		current_action = "Idle"


func store_animation_spot():
	stored_frame = get_node("AnimationPlayer").get_current_animation_pos()

func restore_animation_spot(offset=0):
	get_node("AnimationPlayer").seek(stored_frame + offset, true)

func play(anim):
	if get_node("AnimationPlayer").has_animation(anim):
		get_node("AnimationPlayer").play(anim)

func play_action(action, direction, backwards=false):
	var d = Glb.get_direction_name(direction)
	var anim_name = d + "-" + action

	if not get_node("AnimationPlayer").has_animation(anim_name):
		return false

	if anim_name != get_node("AnimationPlayer").get_current_animation():
		var emit_prev = false
		prev_anim = get_node("AnimationPlayer").get_current_animation()
		prev_frame = get_node("AnimationPlayer").get_current_animation_pos()
		if backwards:
			get_node("AnimationPlayer").play_backwards(anim_name)
		else:
			get_node("AnimationPlayer").play(anim_name)
		if current_action == action:
			get_node("AnimationPlayer").seek(prev_frame, true)
			emit_prev = true
		current_action = action

	return true

func react(action, var1=null): 
    if get_parent().has_method("react"):
        get_parent().react(action, var1)



func get_sprite(): return get_node("Sprite")

func pause():
	get_node("AnimationPlayer").stop()

func add_animation_speed(factor):
	var speed = get_node("AnimationPlayer").get_speed()
	get_node("AnimationPlayer").set_speed(speed + factor)

func play_backwards_from_spot():
	var an = get_node("AnimationPlayer").get_current_animation()
	var frame = get_node("AnimationPlayer").get_current_animation_pos()
	get_node("AnimationPlayer").play_backwards(an)
	get_node("AnimationPlayer").seek(frame, true)

func scale_sprite(scale):
	get_node("Sprite").set_scale(scale)


func slow(amount):
	get_node("AnimationPlayer").set_speed(amount)