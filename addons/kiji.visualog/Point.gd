tool
extends Node2D


enum POINT_TYPES {CROSS, VECT}
export (int, "CROSS", "VECT") var point_type = POINT_TYPES.CROSS setget set_point_type, get_point_type
export (Color) var color = Color(1.0, 0.0, 0.0) setget set_color, get_color
export (Vector2) var vector = Vector2(0, 0) setget set_vector, get_vector


func _draw():
	if point_type == POINT_TYPES.CROSS:
		_draw_cross()
	elif point_type == POINT_TYPES.VECT:
		_draw_vect()

func set_point_type(value): 
	point_type = value
	update()
func get_point_type(): return point_type

func set_color(value): 
	color = value
	update()
func get_color(value): return color

func set_vector(value): 
	vector = value
	update()
func get_vector(value): return vector

func _rotate_vector(vec, dev=0):
	var rot = get_parent().get_rot() + dev
	return Vector2(vec.x*cos(rot) - vec.y*sin(rot), vec.x*sin(rot) + vec.y*cos(rot))	

func _draw_cross():
	var point = Vector2()
	draw_line(point + Vector2(0, 2), point + Vector2(0, 10), color, 2) # down
	draw_line(point + Vector2(0, -2), point + Vector2(0, -10), color, 2) # up
	draw_line(point + Vector2(2, 0), point + Vector2(10, 0), color, 2) # right
	draw_line(point + Vector2(-2, 0), point + Vector2(-10, 0), color, 2) # left

func _draw_vect():
	var point = Vector2()
	var vec = _rotate_vector(vector)
	var arr1 = _rotate_vector(vector*0.9, 0.3)
	var arr2 = _rotate_vector(vector*0.9, -0.3)

	draw_line(point, vec, color, 2)
	draw_line(vec, arr1, color, 2)
	draw_line(vec, arr2, color, 2)
