extends Button

onready var cam = get_parent().get_node("cam")

func _on_openCam_pressed():
	if Global.power_left:
		cam.visible = !cam.visible
		MusicHandler.play("open_cam")
	
	if get_tree().get_current_scene().name != "main":
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/main.tscn")
		Global.changed_scene()
