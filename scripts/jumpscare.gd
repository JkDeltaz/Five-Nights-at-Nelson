extends CanvasLayer


func _on_anim_animation_finished(_anim_name):
	get_tree().paused = false
	Global.end_night()
