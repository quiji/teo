
func process(packed_scene):

    var scene = packed_scene.instance()
    var script = preload("res://objects/ghosts/juancho_sprite_handler.gd") 
        
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
        if anims[i].ends_with("Idle") and anims[i].begins_with("Down-"):
            anim.set_autoplay(anims[i])
        i += 1 
