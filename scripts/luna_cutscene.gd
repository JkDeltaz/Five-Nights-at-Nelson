extends Node2D

func _process(_delta):
	if Input.is_action_just_pressed("left_mouse"):
		get_tree().change_scene("res://scenes/menu.tscn")
		

func _on_anim_animation_finished(_anim_name):
	get_tree().change_scene("res://scenes/menu.tscn")
