extends Camera2D

var moving_left
var moving_right


func _process(_delta):
	if moving_left and (position.x - 200) > 0:
		position.x -= 8
	if moving_right and (position.x + 200) < 1100:
		position.x += 8

func _on_left_mouse_entered():
	moving_left = true

func _on_right_mouse_entered():
	moving_right = true

func _on_left_mouse_exited():
	moving_left = false

func _on_right_mouse_exited():
	moving_right = false
