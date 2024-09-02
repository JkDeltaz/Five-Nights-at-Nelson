extends Node2D

var current_question

var questions: Dictionary = {"Quanto é 1+1?": ["11", "2", "0", "978"],
							 "O que é H20?": ["Água", "Sangue", "Dengue", "Rato"],
							"O que o Alura vende?": ["Comida", "Códigos", "Cursos", "Água"],
							"Quem é a diretora?": ["Ilka", "Thaís", "Jorge", "Cláudia"],
							"Qual a cor do céu?": ["Roxo", "Amarelo", "Azul", "Verde"],
							"Quem pintou a Monalisa?": ["Da Vinci", "Lula", "Monet", "Van Gogh"],
							"Quanto é 9*7?": ["63", "49", "72", "81"],
							"Qual a maior bacia do Brasil?": ["Água", "Acre", "Amazonas", "Paraná"],
							"Qual é abiótico?": ["Plantas", "Fogo", "Bactérias", "Vaca"],
							"Qual a raíz quadrada de 225?": ["5", "25", "15", "125"]}

var answers: Dictionary = {"Quanto é 1+1?": "2",
							 "O que é H20?": "Água",
							"O que o Alura vende?": "Cursos",
							"Quem é a diretora?": "Cláudia",
							"Qual a cor do céu?": "Azul",
							"Quem pintou a Monalisa?": "Da Vinci",
							"Quanto é 9*7?": "63",
							"Qual a maior bacia do Brasil?": "Amazonas",
							"Qual é abiótico?": "Fogo",
							"Qual a raíz quadrada de 225?": "15"}

func _ready():
	next_question()

func next_question():
	if Global.night_time <= 5:
		current_question = questions.keys()[randi() % len(questions.keys())]
#		current_question = questions.keys()[9]
		$questionText.text = current_question

		$answer_01.text = "A. "+questions[current_question][0]
		$answer_02.text = "B. "+questions[current_question][1]
		$answer_03.text = "C. "+questions[current_question][2]
		$answer_04.text = "D. "+questions[current_question][3]


func _on_answer_01_pressed():
	if answers[current_question] in $answer_01.text:
		Global.answer(true)
	else:
		Global.answer(false)
	next_question()

func _on_answer_02_pressed():
	if answers[current_question] in $answer_02.text:
		Global.answer(true)
	else:
		Global.answer(false)
	next_question()

func _on_answer_03_pressed():
	if answers[current_question] in $answer_03.text:
		Global.answer(true)
	else:
		Global.answer(false)
	next_question()

func _on_answer_04_pressed():
	if answers[current_question] in $answer_04.text:
		Global.answer(true)
	else:
		Global.answer(false)
	next_question()
