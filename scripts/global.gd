extends Node

var move_counter: int = 0

var current_night = 5
var night_seven = false
var in_night_seven = false

var night_time = 0

var power_left = 100

const SAVE_PATH = "user://fnan.save"

# warning-ignore:unused_signal
signal move_counter
signal changed_scene
signal night_started
signal hour_passed

var door = "nothing"
var window = "nothing"

var pombo_scare = 0
var aluraman_jumpscare_counter = 0

var is_door_closed = false

var night_started = false

var rato_jumpscare = preload("res://scenes/rato_jumpscare.tscn")
var pombo_jumpscare = preload("res://scenes/pombo_jumpscare.tscn")
var aluraman_jumpscare = preload("res://scenes/aluraman_jumpscare.tscn")

var question_time = false
var jumpscared = false


func _ready():
	var file = File.new()
	var placeholder
	
	current_night = 1
	night_seven = false
	
	if file.file_exists("user://fnan.save"):
		file.open("user://fnan.save", File.READ)
		placeholder = file.get_var()
		current_night = placeholder[0]
		night_seven = placeholder[1]
		file.close()

# warning-ignore:function_conflicts_variable
func night_started():
	night_started = true
	power_left = 100
	night_time = 0
	pombo_scare = 0
	jumpscared = false
	emit_signal("night_started")

func hour_passed():
	night_time += 1
	if night_time == 6:
		end_night()
	else:
		MusicHandler.play_random_sound()
	emit_signal("hour_passed")

func changed_scene():
	emit_signal("changed_scene")

func jumpscare(animatronic):
	
	if animatronic == "rato":
		get_tree().get_current_scene().add_child(rato_jumpscare.instance())
	if animatronic == "pombo":
		get_tree().get_current_scene().add_child(pombo_jumpscare.instance())
	if animatronic == "aluraman":
		get_tree().get_current_scene().add_child(aluraman_jumpscare.instance())

	door = "nothing"
	window = "nothing"
	jumpscared = true
	get_tree().paused = true

func end_night():
# warning-ignore:return_value_discarded
	if not jumpscared:
		get_tree().change_scene("res://scenes/6am_cutscene.tscn")
		if Global.current_night == 6:
			night_seven = true
		Global.current_night += 1 if Global.current_night < 6 else 0
		_save()

	else:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/menu.tscn")
		MusicHandler.menu_music()
	Global.night_started = false
	is_door_closed = false
	question_time = false
	aluraman_jumpscare_counter = 0
	CmspTimer.position = "cam_0a"


func answer(correct):
	if not correct:
		aluraman_jumpscare_counter += 1
		MusicHandler.play("wrong_answer")
	else:
		if night_time < 5:
			MusicHandler.play("right_answer")
		else:
			MusicHandler.play("last_answer")
	
	if aluraman_jumpscare_counter >= (8 - current_night):
		CmspTimer.start_attack_counter()
	
	CmspTimer.stop()
	question_time = false

func power_shutdown():
	if get_tree().get_current_scene().name != "main":
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/main.tscn")
	yield(get_tree().create_timer(0.001), "timeout")
	Rato.map_position = "door"
	MusicHandler.play("power_shutdown")
	get_tree().get_current_scene().get_node("dark_screen/anim").play("fade_in")

func _save():
	var file = File.new()
	file.open("user://fnan.save", File.WRITE)
	file.store_var([Global.current_night, Global.night_seven])
	file.close()
