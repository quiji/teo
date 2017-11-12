
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
        #if anims[i].ends_with("Idle") and anims[i].begins_with("Down-"):
        #    anim.set_autoplay(anims[i])
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
    an.track_insert_key(track, 0.15, Vector2(0, -2))
    an.track_insert_key(track, 0.33, Vector2(0, 0))
    an.track_insert_key(track, 0.48, Vector2(0, -1))
    an.track_insert_key(track, 0.63, Vector2(0, -2))
    an.track_insert_key(track, 0.81, Vector2(0, 0))

