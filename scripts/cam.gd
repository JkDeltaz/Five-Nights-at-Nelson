extends Node2D


func _process(_delta):
	if get_tree().get_current_scene().name == "main":
		modulate = "ffffff"
	else:
		modulate = "7effffff"
	
	for cam in get_children():
		if cam.has_method("is_flat") and cam.pressed:
			if not get_tree().get_current_scene().name in "res://cams/cam_0"+cam.name[-1]+".tscn":
# warning-ignore:return_value_discarded
				get_tree().change_scene("res://cams/cam_0"+cam.name[-1]+".tscn")
				Global.changed_scene()
				MusicHandler.cam_sound()
