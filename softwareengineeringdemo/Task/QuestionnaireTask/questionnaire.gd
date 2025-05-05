extends Node2D

var QuestionDictionary = [
	{
		"Question" : "What is the capital of England",
		"Choices" : ["Paris" , "London" , "Berlin" , "Dublin"],
		"Correct Answer" : "London",
	},
	{
		"Question" : "What is the 4th planet from the sun",
		"Choices" : ["Mercury" , "Venus" , "Earth" , "Mars"],
		"Correct Answer" : "Mars",
	}
] ##list of all the questions and their info

var CurrentQuestionIndex = 0 ##index of the current questions
var CurrentQuestion = {} ##container for the current question
var TurnsTaken = 0

##assigns labels and buttons to variables
@onready var QuestionLabel = $"QuestionLabel"
@onready var Button1 = $"HSplitContainer/VSplitContainer/Button1"
@onready var Button2 = $"HSplitContainer/VSplitContainer/Button2"
@onready var Button3 = $"HSplitContainer/VSplitContainer2/Button3"
@onready var Button4 = $"HSplitContainer/VSplitContainer2/Button4"


func _ready() -> void:
	LoadQuestion()


func LoadQuestion():
	CurrentQuestion = QuestionDictionary[CurrentQuestionIndex] ##the current question is the index of the dictionary
	QuestionLabel.text = CurrentQuestion["Question"] ##assign question to label
	
	##assign the answer choices to the buttons
	Button1.text = CurrentQuestion["Choices"][0]
	Button2.text = CurrentQuestion["Choices"][1]
	Button3.text = CurrentQuestion["Choices"][2]
	Button4.text = CurrentQuestion["Choices"][3]


func CheckAnswer(SelectedAnswer: String):
	if SelectedAnswer == CurrentQuestion["Correct Answer"]: ##if you got the correct answer
		CurrentQuestionIndex += 1 ##increment the quesiton index
		TurnsTaken += 1
		LoadQuestion() ##load new questions
	else:
		TurnsTaken += 1
	

func OnButton1Pressed() -> void:
	CheckAnswer(Button1.text)


func OnButton2Pressed() -> void:
	CheckAnswer(Button2.text)


func OnButton3Pressed() -> void:
	CheckAnswer(Button3.text)


func OnButton4Pressed() -> void:
	CheckAnswer(Button4.text)
