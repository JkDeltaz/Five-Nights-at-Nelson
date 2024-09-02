extends Node2D


func _process(_delta):
	if Input.is_action_pressed("left_mouse"):
		change_scene_to_office()

func change_scene_to_office():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/noitada_cutscene.tscn")
