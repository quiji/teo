extends Node2D

var objects_to_move = []

func _ready():
    get_node("playground").add_objects(objects_to_move)

func place_objects_on_playground(objects):
    var i = 0
    while i < objects.size():
        objects_to_move.append(objects[i])
        i += 1

func place_object_on_fallers(obj):
    get_node("fallers").add_child(obj)
    obj.free_fall()