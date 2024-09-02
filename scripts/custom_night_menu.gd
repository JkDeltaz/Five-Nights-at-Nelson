extends Node2D


var pombo_diff = 5
var aluraman_diff = 5
var rato_diff = 5


func _process(_delta):
	$pombo_diff/text.text = "0"+str(pombo_diff) if pombo_diff < 10 else str(pombo_diff)
	$aluraman_diff/text.text = "0"+str(aluraman_diff) if aluraman_diff < 10 else str(aluraman_diff)
	$rato_diff/text.text = "0"+str(rato_diff) if rato_diff < 10 else str(rato_diff)


func _on_less_btn_pressed():
	pombo_diff -= 1 if pombo_diff > 0 else 0

func _on_more_btn_pressed():
	pombo_diff += 1 if pombo_diff < 20 else 0


func _on_less_btn_pressed_aluraman():
	aluraman_diff -= 1 if aluraman_diff > 0 else 0

func _on_more_btn_pressed_aluraman():
	aluraman_diff += 1 if aluraman_diff < 20 else 0

func _on_less_btn_pressed_rato():
	rato_diff -= 1 if rato_diff > 0 else 0

func _on_more_btn_pressed_rato():
	rato_diff += 1 if rato_diff < 20 else 0


func _on_continue_pressed():
	Pombo.custom_difficulty = pombo_diff
	CmspTimer.custom_difficulty = aluraman_diff
	Rato.custom_difficulty = rato_diff
	get_tree().change_scene("res://scenes/noitada_cutscene.tscn")
