extends Node2D


func _ready():
	MusicHandler.play("6am")
	MusicHandler.stop("light_sound")
	MusicHandler.stop("ambience")

# warning-ignore:unused_argument
func _on_anim_animation_finished(anim_name):
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/menu.tscn")
	MusicHandler.menu_music()
