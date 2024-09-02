extends Node2D


var textures = {1: "res://assets/noitadas/Noitada_1.webp", 2: "res://assets/noitadas/Noitada_2.webp",
				3: "res://assets/noitadas/Noitada_3.webp", 4: "res://assets/noitadas/Noitada_4.webp",
				5: "res://assets/noitadas/Noitada_5.webp", 6: "res://assets/noitadas/Noitada_6.webp"}

func _ready():
	$sprite.texture = load(textures.get(Global.current_night))
	
	if Global.in_night_seven:
		$sprite.texture = load("res://assets/noitadas/Noitada_E.webp")

func _process(_delta):
	if Input.is_action_pressed("left_mouse"):
		change_scene_to_office()

func change_scene_to_office():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/main.tscn")
	MusicHandler.night_started()
