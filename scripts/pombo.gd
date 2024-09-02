extends Node

var map_position = 5

var map_route = [5, 6, 3, 2, 1, 4, 7, "window"]

var old_position
var new_position

var attack_counter = 0
var waiting_for_cam = false

var night_difficulty = {1: 1, 2: 4, 3: 6, 4: 9, 5: 11, 6: 14}
var custom_difficulty = 0
var difficulty = 3

func _ready():
	randomize()
# warning-ignore:return_value_discarded
	Global.connect("move_counter", self, "move")
# warning-ignore:return_value_discarded
	Global.connect("night_started", self, "reset")

func _process(_delta):
	if not Global.in_night_seven:
		difficulty = night_difficulty.get(Global.current_night) + Global.night_time  - 1
	else:
		difficulty = custom_difficulty + Global.night_time - 1 if custom_difficulty else custom_difficulty
	if not "cutscene" in get_tree().get_current_scene().name:
		if str(map_position) in get_tree().get_current_scene().name:
			get_tree().get_current_scene().get_node("pombo_sprite").visible = true
		else:
			if "cam" in get_tree().get_current_scene().name:
				get_tree().get_current_scene().get_node("pombo_sprite").visible = false
	
	if Global.pombo_scare >= 10 and Global.window == "pombo":
		Global.pombo_scare = 0
		attack_counter = 0
		waiting_for_cam = true

	if "cam" in get_tree().get_current_scene().name and waiting_for_cam:
		Global.window = "nothing"
		MusicHandler.play("pombo_scare")
		waiting_for_cam = false
		map_position = map_route[randi() % 3]

func move(insta_move):
	if not "menu" in get_tree().get_current_scene().name and not "cutscene" in get_tree().get_current_scene().name:
		var rand_move_opportunity = randi() % 20 + 1 
		if rand_move_opportunity <= difficulty or insta_move:
			if str(map_position) != "window":
				old_position = map_position
				map_position = map_route[map_route.find(map_position)+1]
				new_position = map_position
			
		
			if str(old_position) in get_tree().get_current_scene().name or str(new_position) in get_tree().get_current_scene().name:
				get_tree().get_current_scene().get_node("static_gif/anim").play("animatronic_moved")
		
		if str(map_position) == "window":
			Global.window = "pombo"
			attack_counter += 1
			if attack_counter >= 9 - Global.current_night and Global.pombo_scare <= 10:
				Global.jumpscare("pombo")


func reset():
	attack_counter = 0
	map_position = 5
	difficulty = 5
	Global.window = "nothing"
