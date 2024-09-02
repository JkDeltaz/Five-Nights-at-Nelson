extends Node



func _ready():
	$menu_music.volume_db = 0

func night_started():
	$menu_music/anim.play("fade_out")
	$ambience/anim.play("fade_in")

func menu_music():
	$ambience.stop()
	$menu_music/anim.play("fade_in")

func cam_sound():
	$cam_audio.play()

func play_random_sound():
	var random_sound_int = randi() % 5 + 1
	match random_sound_int:
		1:
			play("rato_laugh")
		2:
			play("rato_squeak")
		3:
			play("pombo_fly")
		4:
			play("kitchen")
		5:
			play("running")

func play(sound):
	for child in get_children():
		if sound in child.name and sound != "light_sound":
			child.play()
	if sound == "light_sound":
		if $light_sound.playing == false:
			$light_sound.play()

func stop(sound):
	for child in get_children():
		if sound in child.name:
			child.stop()
