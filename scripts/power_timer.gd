extends Timer


var power_usage = []

var shutdown = false

func _ready():
# warning-ignore:return_value_discarded
	Global.connect("night_started", self, "_night_started")

func _night_started():
	wait_time = 1
	shutdown = false
	start()

func _process(_delta):
	if Input.is_action_pressed("ui_down"):
		Global.power_left -= 1
	
	var old_power_usage = len(power_usage)
	
	if Global.is_door_closed and not power_usage.has("d"):
		power_usage.append("d")
	elif not Global.is_door_closed and power_usage.has("d"):
		power_usage.remove(power_usage.find("d"))
	
	if "cam" in get_tree().get_current_scene().name and not power_usage.has("cam"):
		power_usage.append("cam")
	elif not "cam" in get_tree().get_current_scene().name and power_usage.has("cam"):
		power_usage.remove(power_usage.find("cam"))
	
	var new_power_usage = len(power_usage)
	
	wait_time = 6 - len(power_usage)*2.5
	
	if old_power_usage != new_power_usage and time_left > wait_time:
		start()

func _on_power_timer_timeout():
	if not shutdown:
		if Global.power_left == 1:
			Global.power_shutdown()
			shutdown = true
			Global.power_left -= 1
		else:
			Global.power_left -= 1
