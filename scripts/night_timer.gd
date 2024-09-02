extends Timer


func _ready():
# warning-ignore:return_value_discarded
	Global.connect("night_started", self, "_night_started")

func _process(_delta):
	if "menu" in get_tree().get_current_scene().name or "cutscene" in get_tree().get_current_scene().name:
		stop() 
	
	if Input.is_action_just_pressed("ui_home"):
		Global.hour_passed()

func _night_started():
	wait_time = 50
	start()

func _on_night_timer_timeout():
	Global.hour_passed()
