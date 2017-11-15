
func process(packed_scene):

    var scene = packed_scene.instance()
    var script = preload("res://teo/sprite_handler.gd") 
        
    scene.set_name("sprite_handler")
    scene.set_script(script)

    prepare_animation_player(scene.get_node("AnimationPlayer"))

    var error = packed_scene.pack( scene )
    scene.call_deferred( 'free' )
    return error

func prepare_animation_player(anim):
    anim.set_animation_process_mode(AnimationPlayer.ANIMATION_PROCESS_FIXED)

    var anims = anim.get_animation_list()
    var i = 0
    while i < anims.size():
        var an = anim.get_animation(anims[i])
        if anims[i].ends_with("Run"):
            prepare_run_anim(an)
        if anims[i].ends_with("FrontThrow"):
            prepare_front_throw_anim(an)
        if anims[i].ends_with("SideThrow"):
            prepare_side_throw_anim(an)
        if anims[i].ends_with("-Throw"):
            prepare_throw_anim(an, anims[i])
        i += 1 


func prepare_run_anim(an):
    var track = an.add_track(Animation.TYPE_METHOD)
    an.track_set_path(track, ".")
    var method = {
        "method": "react",
        "args": ["Step"]
    }
    an.track_insert_key(track, 0.33, method)
    an.track_insert_key(track, 0.81, method)

    track = an.add_track(Animation.TYPE_VALUE)
    an.track_set_path(track, "Sprite:offset")
    an.track_insert_key(track, 0, Vector2(0, -1))
    an.track_insert_key(track, 0.15, Vector2(0, -3))
    an.track_insert_key(track, 0.33, Vector2(0, 0))
    an.track_insert_key(track, 0.48, Vector2(0, -1))
    an.track_insert_key(track, 0.63, Vector2(0, -3))
    an.track_insert_key(track, 0.81, Vector2(0, 0))

func prepare_side_throw_anim(an):
    var track = an.add_track(Animation.TYPE_METHOD)
    an.track_set_path(track, ".")
    var method = {
        "method": "react",
        "args": ["Step"]
    }
    an.track_insert_key(track, 0.15, method)
    an.track_insert_key(track, 0.75, method)

    track = an.add_track(Animation.TYPE_VALUE)
    an.track_set_path(track, "Sprite:offset")
    an.track_insert_key(track, 0, Vector2(0, 0))
    an.track_insert_key(track, 0.45, Vector2(0, -2))

func prepare_front_throw_anim(an):
    var track = an.add_track(Animation.TYPE_METHOD)
    an.track_set_path(track, ".")
    var method = {
        "method": "react",
        "args": ["Step"]
    }
    an.track_insert_key(track, 0.12, method)
    an.track_insert_key(track, 0.48, method)

    track = an.add_track(Animation.TYPE_VALUE)
    an.track_set_path(track, "Sprite:offset")

func prepare_throw_anim(an, name):
    an.set_loop(false)
    var track = an.add_track(Animation.TYPE_METHOD)
    an.track_set_path(track, ".")

    var pos = Vector2()
    if name.begins_with("Down-"): pos = Vector2(0, 5)
    elif name.begins_with("DownLeft-"): pos = Vector2(-5, 5)
    elif name.begins_with("Left-"): pos = Vector2(-5, 0)
    elif name.begins_with("UpLeft-"): pos = Vector2(-5, -5)
    elif name.begins_with("Up-"): pos = Vector2(0, -5)
    elif name.begins_with("UpRight-"): pos = Vector2(5, -5)
    elif name.begins_with("Right-"): pos = Vector2(5, 0)
    elif name.begins_with("DownRight-"): pos = Vector2(5, 5)
        

    var method = {
        "method": "react",
        "args": ["Throw", pos]
    }
    an.track_insert_key(track, 0.36, method)