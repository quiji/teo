extends Node2D

const Single_Vector = 0
const Direction_Mark_8 = 1
const CrossMark = 2

var direction = Vector2()
export (Color) var vector_color = Color(0, 0, 0)
export (int, "Single_Vector", "Direction_Mark_8", "CrossMark") var mode = Single_Vector
export (bool) var enabled = true

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _draw():

	if enabled:
		if mode == Single_Vector:
			draw_line(Vector2(), direction * 20, vector_color, 1)
		elif mode == CrossMark:
			draw_line(Vector2(-5, 0), Vector2(5, 0), vector_color, 1)
			draw_line(Vector2(0, -5), Vector2(0, 5), vector_color, 1)
		else:
			draw_line(Vector2(), Glb.Directions.Up * 20, vector_color, 1)
			draw_line(Vector2(), Glb.Directions.UpLeft * 20, vector_color, 1)
			draw_line(Vector2(), Glb.Directions.Left * 20, vector_color, 1)
			draw_line(Vector2(), Glb.Directions.DownLeft * 20, vector_color, 1)
			draw_line(Vector2(), Glb.Directions.Down * 20, vector_color, 1)
			draw_line(Vector2(), Glb.Directions.DownRight * 20, vector_color, 1)
			draw_line(Vector2(), Glb.Directions.Right * 20, vector_color, 1)
			draw_line(Vector2(), Glb.Directions.UpRight * 20, vector_color, 1)
		
		

func set_direction(dir):
	direction = dir
	update()

func manifest(pos):
	set_global_pos(pos)
	update()