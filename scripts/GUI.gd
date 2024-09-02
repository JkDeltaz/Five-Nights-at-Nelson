extends CanvasLayer



# POWER USAGE

func _process(_delta):
	$power_left_num.text = ":"+str(Global.power_left)+"%"
	$night_timer_text.text = "0"+str(Global.night_time)+":00"
	
	if not Global.in_night_seven:
		$current_night_text.text = "Noite "+str(Global.current_night)
	else:
		$current_night_text.text = "Noite 7"
	
	if not "main" in get_tree().get_current_scene().name and not "cam" in get_tree().get_current_scene().name:
		visible = false
	else:
		visible = true
	
	if "cam" in get_tree().get_current_scene().name and Global.question_time:
		$notification.visible = true
	else:
		$notification.visible = false

# NIGHT TIME
