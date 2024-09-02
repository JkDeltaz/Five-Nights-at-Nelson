extends Timer


func _ready():
	wait_time = 4
# warning-ignore:return_value_discarded
	Global.connect("night_started", self, "start_timer")

func start_timer():
	start()

func _process(_delta):
	if "menu" in get_tree().get_current_scene().name or "cutscene" in get_tree().get_current_scene().name:
		stop()

func _on_move_timer_timeout():
	Global.emit_signal("move_counter", false)
