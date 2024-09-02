extends Button


onready var cmsp = get_parent().get_node("cmsp")

func _ready():
	pass

func _process(_delta):
	if Global.question_time:
		$text.visible = true
		disabled = false
	else:
		$text.visible = false
		disabled = true
		cmsp.visible = false

func _on_open_cmsp_pressed():
	if Global.power_left:
		cmsp.visible = !cmsp.visible
		MusicHandler.play("open_cam")
		cmsp.next_question()
