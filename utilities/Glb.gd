extends Node


# **********************************************************************
#           Globals node
#
#  Globals and constants.
# **********************************************************************


var keyboard = {
    Left = KEY_LEFT,
    Right = KEY_RIGHT,
    Up = KEY_UP,
    Down = KEY_DOWN,
    Throw = KEY_A,

    SkipLeft = KEY_Q,
    SkipRight = KEY_E,
    Slide = KEY_W,
    Grab = KEY_D,
    Attack = KEY_S
}

var keyboard_merged_buttons = {
    UpLeft = ["Up", "Left"],
    UpRight = ["Up", "Right"],
    DownLeft = ["Down", "Left"],
    DownRight = ["Down", "Right"],
    SkipLR = ["SkipLeft", "SkipRight"]
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

enum ObjectTypes { Teo, Wall, Bullet, Pickable, Enemy }

var TeoStats = {
    speed = 200,
    acceleration = 0.2
}

var BulletStats = {
    speed = 500
}