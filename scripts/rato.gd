extends Node

var map_position = 5

var map_route = [5, 4, 1, 2, 3, 6, 8, 9, "door"]

var old_position
var new_position

var attack_counter = 0

var night_difficulty = {1: 3, 2: 5, 3: 7, 4: 10, 5: 12, 6: 15}
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
			get_tree().get_current_scene().get_node("rato_sprite").visible = true
		else:
			if "cam" in get_tree().get_current_scene().name:
				get_tree().get_current_scene().get_node("rato_sprite").visible = false

func move(insta_move):
	if not "menu" in get_tree().get_current_scene().name and not "cutscene" in get_tree().get_current_scene().name:
		var rand_move_opportunity = randi() % 20 + 1 
		if rand_move_opportunity <= difficulty or insta_move:
			if str(map_position) != "door":
				old_position = map_position
				map_position = map_route[map_route.find(map_position)+1]
				new_position = map_position
			
		
			if str(old_position) in get_tree().get_current_scene().name or str(new_position) in get_tree().get_current_scene().name:
				get_tree().get_current_scene().get_node("static_gif/anim").play("animatronic_moved")
		
		if str(map_position) == "door":
			Global.door = "rato"
			attack_counter += randi() % 2 + 1
			if attack_counter >= 5:
				if not Global.is_door_closed:
					Global.jumpscare("rato")
				else:
					MusicHandler.play("door_bang")
					map_position = map_route[randi() % 3]
					Global.door = "nothing"
					attack_counter = 0
		
func reset():
	attack_counter = 0
	map_position = 5
	difficulty = 5
	Global.door = "nothing"
