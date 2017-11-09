extends Node

# Resolutions: 
# 320x180 
# 400x225 (Based on Shovel Kinght's res to fit 16:9)
# 400x240 (Based on Shovel Kinght's res)
# -> 480x270 (Based on Hyper Light Drifter's res)
# 640x360 

onready var root = get_tree().get_root()
onready var base_size = root.get_rect().size

func _ready():
    get_tree().connect("screen_resized", self, "_on_screen_resized")

    root.set_as_render_target(true)
    root.set_render_target_update_mode(root.RENDER_TARGET_UPDATE_ALWAYS)
    root.set_render_target_to_screen_rect(root.get_rect())

    OS.set_window_maximized(true)
    OS.set_window_fullscreen(true)


## Courtesy of CowThing, thanks man!
# https://github.com/godotengine/godot/issues/6506#issuecomment-247533233

func _on_screen_resized():
    var new_window_size = OS.get_window_size()

    var scale_w = max(int(new_window_size.x / base_size.x), 1)
    var scale_h = max(int(new_window_size.y / base_size.y), 1)
    var scale = min(scale_w, scale_h)

    #This offset is needed to keep pixels square
    var offset = ((new_window_size / scale) - (new_window_size / scale).floor()) * scale
    var offsethalf = (offset * 0.5).floor()

    root.set_rect(Rect2(offsethalf, new_window_size / scale))
    root.set_render_target_to_screen_rect(Rect2(offsethalf, new_window_size - offset))
