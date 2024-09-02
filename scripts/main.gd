extends Node2D

var jumpscare_sound_played = false

func _ready():
	$openButtons/cam.visible = false
	if not Global.night_started:
		Global.night_started() 
	if CmspTimer.ready_to_attack:
		$aluraman.visible = true
	else:
		$aluraman.visible = false

func _process(_delta):
	if $right_light.pressed == true and Global.power_left and not Global.is_door_closed:
		MusicHandler.play("light_sound")
		if  Global.door == "rato":
			$door_rato.visible = true
			if not jumpscare_sound_played:
				MusicHandler.play("window_jumpscare")
				jumpscare_sound_played = true
	else:
		$door_rato.visible = false
		MusicHandler.stop("light_sound")

	if Global.window == "pombo":
		$window_pombo.visible = true
	else:
		$window_pombo.visible = false
	
	if not Global.power_left:
		Global.is_door_closed = false
	
	if Global.is_door_closed:
		$office_sprites/door/anim.play("closed")
		$darkness.visible = false
	else:
		$office_sprites/door/anim.play("open")
		$darkness.visible = true

func _on_door_pressed():
	if Global.power_left:
		Global.is_door_closed = !Global.is_door_closed
		
		MusicHandler.play("door_sound")

func _on_right_light_button_up():
	$darkness/anim.play("fade_in")


func _on_right_light_button_down():
	$darkness/anim.play("fade_out")


func _on_left_light_button_down():
	if $window_pombo/anim.current_animation != "light_up":
		$window_pombo/anim.play("light_up")
		MusicHandler.play("lantern_sound")
		if Global.window == "pombo":
			Global.pombo_scare += 1


func _on_left_light_button_up():
	$window_pombo/anim.play("light_down")
