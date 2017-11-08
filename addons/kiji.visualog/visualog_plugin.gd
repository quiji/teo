tool
extends EditorPlugin

func _enter_tree():
    if not Globals.has("autoload/LoggerBase"):
        Globals.set("autoload/LoggerBase", "*res://addons/kiji.visualog/LoggerBase.tscn")
        Globals.set_persisting("autoload/LoggerBase", true)
        Globals.save()
    add_custom_type("VisualLogger", "Node2D", preload("VisualLogger.gd"), preload("icon.png"))


func _exit_tree():
    if Globals.has("autoload/LoggerBase"):
        Globals.set("autoload/LoggerBase", null)
        Globals.save()

    remove_custom_type("VisualLogger")