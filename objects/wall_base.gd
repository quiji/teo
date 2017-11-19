extends StaticBody2D


func get_object_type(): return Glb.ObjectTypes.Wall


#func _ready():

    #if has_node("object_behind_area"):
        #get_node("object_behind_area").connect("body_enter", self, "on_body_behind_wall")
        #get_node("object_behind_area").connect("body_exit", self, "on_body_exit_wall")
        

func on_body_behind_wall(body):
    get_node("tween").interpolate_property(self, "visibility/opacity", 1, 0.5, 1, Tween.TRANS_SINE, Tween.EASE_OUT)
    get_node("tween").start()

func on_body_exit_wall(body):
    get_node("tween").interpolate_property(self, "visibility/opacity", 0.5, 1, 1, Tween.TRANS_SINE, Tween.EASE_OUT)
    get_node("tween").start()
