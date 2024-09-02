extends Control

func _ready():
	modulate = "ffffff"
	MusicHandler.stop("light_sound")
	
	var file = File.new()
	if file.file_exists("user://fnan.save"):
		$continue.visible = true
	else:
		$continue.visible = false
	
	if Global.night_seven:
		$custom_night.visible = true
	else:
		$custom_night.visible = false


func _process(_delta):
	if $continue.is_hovered():
		$continue/night_sprite.visible = true
		if not Global.night_seven:
			$continue/night_sprite/anim.play("night_0"+str(Global.current_night))
		else:
			$continue/night_sprite/anim.play("night_06")
	else:
		$continue/night_sprite.visible = false

func _on_new_game_pressed():
	$anim.play("fade_out")
	MusicHandler.play("open_cam")
	Global.current_night = 1
	Global.in_night_seven = false

func _on_continue_pressed():
	$anim.play("fade_out")
	MusicHandler.play("open_cam")
	Global.in_night_seven = false

func _on_custom_night_pressed():
	$anim.play("fade_out")
	MusicHandler.play("open_cam")
	Global.in_night_seven = true


func change_scene_to_cutscene():
# warning-ignore:return_value_discarded
	if Global.current_night == 1:
		get_tree().change_scene("res://scenes/new_game_cutscene.tscn")
	elif Global.in_night_seven:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/custom_night_menu.tscn")
	else:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/noitada_cutscene.tscn")


func _on_reset_pressed():
	var dir = Directory.new()
	dir.remove("user://fnan.save")
	Global._ready()
	_ready()
	



