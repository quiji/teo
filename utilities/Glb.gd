extends Node


# **********************************************************************
#           Globals node
#
#  Globals and constants.
# **********************************************************************


var keyboard = {

    Throw = KEY_SPACE,

    Left = KEY_A,
    Right = KEY_D,
    Up = KEY_W,
    Down = KEY_S
}

var keyboard_merged_buttons = {
    UpLeft = ["Up", "Left"],
    UpRight = ["Up", "Right"],
    DownLeft = ["Down", "Left"],
    DownRight = ["Down", "Right"]
}

var MovementGroup = ["Up", "UpLeft", "Left", "DownLeft", "Down", "DownRight", "Right", "UpRight"]


var Directions = {
    UpLeft = Vector2(-0.707107, -0.707107),
    Up = Vector2(0, -1),
    UpRight = Vector2(0.707107, -0.707107),
    Right = Vector2(1, 0),
    DownRight = Vector2(0.707107, 0.707107),
    Down = Vector2(0, 1),
    DownLeft = Vector2(-0.707107, 0.707107),
    Left = Vector2(-1, 0),
    NoDirection = Vector2()    
}

func get_direction_name(dir):
    var name = ""
    for key in Directions:
        if Directions[key] == dir:
            name = key
    return name

func is_diagonal(dir):
    return dir.x != 0 and dir.y != 0

func find_closest_direction(dir):
    var keys = Directions.keys()
    var i = 0
    var closest = null
    var closest_dot = -1
    while i < keys.size():
        var temp_dot = Directions[keys[i]].dot(dir)
        if temp_dot > closest_dot:
            closest = Directions[keys[i]]
            closest_dot = temp_dot
        i += 1
    return closest

enum ObjectTypes { Teo, Wall, Bullet, Pickable, Ghost }

enum RockTypes { None, Regular, Warp, Shield, EnemyRegular }

var TeoStats = {
    speed = 140,
    aimwalk_speed = 38,
    aimwalk_speed_backwards = 15,
    acceleration = 0.4,
    react_delay = 1
}

var StandardGhostStats = {
    speed = 120,
    walk_speed = 40,
    acceleration = 1,

    react_delay = 1.5,

    idle_time = 3,
    walk_time = 4,
    prepare_throw_time = 5,

    spot_distance = pow(200, 2),

    throw_strength = 0.5
}

var BulletStats = {
    #min_speed = 300,
    min_speed = 100,
    max_speed = 500,
    min_falltime = 4,
    max_falltime = 7,

    min_bullet_time = 0.2,
    max_bullet_time = 1,

    min_throwback = 200,
    max_throback = 400
}

# Receives strength percentage and returns bullets speed
func get_bullet_speed(strength):
    var speed_range = BulletStats.max_speed - BulletStats.min_speed
    return speed_range * clamp(strength, 0, 1.0) + BulletStats.min_speed

func get_bullet_fall_time(strength):
    var time_range = BulletStats.max_falltime - BulletStats.min_falltime
    return time_range * clamp(strength, 0, 1.0) + BulletStats.min_falltime

func get_bullet_time(strength):
    var time_range = BulletStats.max_bullet_time - BulletStats.min_bullet_time
    return time_range * clamp(strength, 0, 1.0) + BulletStats.min_bullet_time
    

func get_bullet_throwback(strength):
    var speed_range = BulletStats.max_throback - BulletStats.min_throwback
    return speed_range * clamp(strength, 0, 1.0) + BulletStats.min_throwback

# **********************************************************************
#           HUD Communication... part
# **********************************************************************

enum HUDActions {
    ThrowChargeBarStart,
    ThrowChargeBarEnd,
    Log
}

var HUD = null

func set_HUD(obj):
    HUD = obj

func tell_HUD(action, values=null):
    if HUD != null:
        return HUD.execute_action(action, values)
    else:
        return false




# **********************************************************************
#           Global Init
# **********************************************************************

func _ready():
    randomize()
