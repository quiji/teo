
func process(packed_scene):

    var scene = packed_scene.instance()
    var script = preload("res://objects/rocks/regular_rock_sprite_handler.gd") 
        
    scene.set_name("sprite_handler")
    scene.set_script(script)

    prepare_animation_player(scene.get_node("AnimationPlayer"))

    var error = packed_scene.pack( scene )
    scene.call_deferred( 'free' )
    return error

func prepare_animation_player(anim):
    anim.set_animation_process_mode(AnimationPlayer.ANIMATION_PROCESS_FIXED)
