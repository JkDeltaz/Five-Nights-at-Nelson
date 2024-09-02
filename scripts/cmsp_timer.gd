extends Timer

var night_difficulty = {1: 5, 2: 5, 3: 5, 4: 6, 5: 10, 6: 12, 7: 0}
var difficulty = 3
var custom_difficulty = 0

var position: String = "cam_0a"
var ready_to_attack = false

func _ready():
# warning-ignore:return_value_discarded
	Global.connect("hour_passed", self, "start_timer")
	wait_time = 12 - Global.current_night

func start_timer():
	start()

func _process(_delta):
	if get_tree().get_current_scene().name == position and not ready_to_attack:
		get_tree().get_current_scene().get_node("aluraman_sprite").visible = true
	else: 
		if get_tree().get_current_scene().has_node("aluraman_sprite"):
			get_tree().get_current_scene().get_node("aluraman_sprite").visible = false

	if Global.aluraman_jumpscare_counter >= (8 - Global.current_night)/2:
		position = "cam_0b"

func _on_cmsp_timer_timeout():
	wait_time = 22 - Global.current_night * 2
	if Global.question_time:
		Global.answer(false)
	stop()

func main_game():
	if "cam" in get_tree().get_current_scene().name or "main" in get_tree().get_current_scene().name:
		return true
	return false

func _on_movement_opp_timeout():
	var movement_opportunity = randi() % 20 + 1
	if not Global.in_night_seven:
		difficulty = night_difficulty.get(Global.current_night) + Global.night_time  - 1
	else:
		difficulty = custom_difficulty + Global.night_time - 1 if custom_difficulty else custom_difficulty
	
	wait_time = 16 - Global.night_time - Global.current_night
	
	if movement_opportunity <= difficulty and not Global.question_time and main_game() and not ready_to_attack:
		MusicHandler.play("notification")
		Global.question_time = true
		start_timer()

func start_attack_counter():
	ready_to_attack = true
	$attack_counter.wait_time = 15-Global.current_night
	$attack_counter.start()

func _on_attack_counter_timeout():
	if not "cutscene" in get_tree().get_current_scene().name and not "menu" in get_tree().get_current_scene().name:
		Global.jumpscare("aluraman")
	ready_to_attack = false
	$attack_counter.stop()
