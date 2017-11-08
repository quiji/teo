extends Node2D

export (Color) var DefaultColor = Color(0.9, 0.9, 0.9) # Default color of Logger text
export (int, "Left", "Right") var location = 0 # Select in which panel to log (left or right sides of the screen). You can switch between panels of the same side by using F1(left)/F2(right) keys
export (bool) var is_enabled = true # Enable/Disable VisualLogger. When disable it ignores calls to it's methods
export (int, "Nano", "Small", "Medium", "Large", "Big") var log_size = 0 # Size of the text in the screen.

onready var Point = preload("res://addons/kiji.visualog/Point.tscn")

var LoggerBase = null
var LogSpace = null
var PointsNode = null

var points = {}

func _ready():
    if PointsNode == null:
        PointsNode = Node2D.new()
        add_child(PointsNode)

func check_for_log_space():
    if LogSpace == null:
        LoggerBase = get_node("/root/LoggerBase")
        LogSpace = LoggerBase.create_log_space(get_parent(), self, DefaultColor, location, log_size)

func update(name, variable, col=DefaultColor):
    if not is_enabled:
        return null

    check_for_log_space()

    if typeof(variable) == TYPE_DICTIONARY:
        if LoggerBase.has_no_label_for_dict(LogSpace, name): LoggerBase.generate_dict_label(LogSpace, name, variable)
    else:
        if LoggerBase.has_no_label_for(LogSpace, name): LoggerBase.generate_label(LogSpace, name)
    LoggerBase.update_label(LogSpace, name, variable, col)

func location(name, position, absolute=false, col=DefaultColor):
    if not is_enabled:
        return null

    check_for_log_space()

    if PointsNode == null:
        return null

    var p = null
    if not points.has(name):
        p = Point.instance()
        # 0 is cross
        p.set_point_type(p.POINT_TYPES.CROSS) 
        points[name] = p
        PointsNode.add_child(p)
        p.set_z(4000)
    else:
        p = points[name]

    p.set_color(col)
    if absolute:
        p.set_global_pos(position)
    else:
        p.set_pos(position)

func vector(name, vect, col=DefaultColor):
    if not is_enabled:
        return null

    check_for_log_space()

    if PointsNode == null:
        return null

    var p = null
    if not points.has(name):
        p = Point.instance()
        # 0 is cross
        p.set_point_type(p.POINT_TYPES.VECT) 
        points[name] = p
        PointsNode.add_child(p)
    else:
        p = points[name]

    p.set_color(col)
    p.set_vector(vect)


func hide_points(): PointsNode.hide()

func show_points(): PointsNode.show()
