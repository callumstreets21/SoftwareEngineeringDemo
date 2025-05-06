extends Control

var QuestionDictionary = [
	{
		"Question" : "You have a choice between two job offers. One offers a higher salary, but with a longer commute, and the other offers a lower salary but closer to home. What should be your first step in making the decision?",
		"Choices" : ["Choose the job with the higher salary, since money is the most important factor." , "Compare the total benefits, including salary, commute time, work-life balance, and personal priorities." , "Choose the job that people in your network suggest." , "Make the decision based on which company seems the most popular."],
		"Correct Answer" : "Compare the total benefits, including salary, commute time, work-life balance, and personal priorities.",
	},
	{
		"Question" : "When faced with a decision that involves potential risks, what is a good strategy for reducing risk?",
		"Choices" : ["Avoid making the decision and hope the situation resolves itself." , "Consult others who have faced similar decisions and gather insights." , "Make a decision quickly to avoid overthinking the problem." , "Ignore potential negative outcomes and focus on possible gains."],
		"Correct Answer" : "Consult others who have faced similar decisions and gather insights.",
	},
	{
		"Question" : "You are deciding between two investment options: one is safe but with low returns, the other is high-risk but with potentially high returns. What factor should you prioritize?",
		"Choices" :	["The investment with the higher return, regardless of risk." , "Your long-term financial goals and risk tolerance." , "The option that friends and family suggest." , "The option with the shortest time commitment."],
		"Correct Answer" : "Your long-term financial goals and risk tolerance.",
	},
	{
		"Question" : "When making a decision with limited information, what is a good approach?",
		"Choices" : ["Wait until you have all the information before making any decisions." , "Make a decision quickly based on your gut feeling." , "Use the information you have to make the best educated guess, but remain flexible." , "Choose the option that seems easiest, regardless of potential long-term consequences."],
		"Correct Answer" : "Use the information you have to make the best educated guess, but remain flexible.",
	},
	{
		"Question" : "If you’re making a decision that will impact a team, what is the best way to involve others in the process?",
		"Choices" : ["Make the decision on your own and present it to the team later." , "Gather input from all team members and consider their perspectives before deciding." , "Consult only the team members you trust and ignore others." , "Make a decision based on what the majority of the team suggests."],
		"Correct Answer" : "Gather input from all team members and consider their perspectives before deciding.",
	},
	{
		"Question" : "You’re faced with a time-sensitive decision. What is the best way to balance speed and accuracy?",
		"Choices" : ["Rush through the decision to save time, and deal with any mistakes later." , "Prioritize making the most accurate decision, even if it takes more time." , "Break down the decision into manageable parts and focus on making quick yet thoughtful choices." , "Make the decision quickly and hope for the best."],
		"Correct Answer" : "Break down the decision into manageable parts and focus on making quick yet thoughtful choices.",
	},
	{
		"Question" : "If a decision could result in a significant loss, what should you do before committing to it?",
		"Choices" : ["Take a leap of faith and hope it works out." , "Evaluate the potential outcomes and consider ways to mitigate losses." , "Consult with people who are most likely to agree with your view." , "Go with the option that feels the most comfortable in the moment."],
		"Correct Answer" : "Evaluate the potential outcomes and consider ways to mitigate losses.",
	},
	{
		"Question" : "When deciding between two equally appealing options, what strategy should you use to make the final choice?",
		"Choices" : ["Flip a coin to leave the decision up to chance." , "Reflect on which option aligns more closely with your long-term goals or values." , "Ask someone else to make the decision for you." , "Choose based on which option will impress others the most."],
		"Correct Answer" : "Reflect on which option aligns more closely with your long-term goals or values.",
	},
	{
		"Question" : "If you’ve made a poor decision that leads to negative outcomes, what is the best course of action?",
		"Choices" : ["Deny the mistake and ignore the consequences." , "Take responsibility, learn from it, and make adjustments moving forward." , "Blame others for the decision." , "Give up on making decisions and wait for others to handle things."],
		"Correct Answer" : "Take responsibility, learn from it, and make adjustments moving forward."
	},
	{
		"Question" : "When deciding whether to pursue a new opportunity, what is an important factor to consider?",
		"Choices" : ["Whether the opportunity has the potential to be immediately rewarding." , "The level of personal interest and passion you have for the opportunity." , "Whether the opportunity is trending or popular right now." , "The opinions of people who have no experience with the opportunity."],
		"Correct Answer" : "The level of personal interest and passion you have for the opportunity.",
	}
] ##list of all the questions and their info

var CurrentQuestionIndex = 0 ##index of the current questions
var CurrentQuestion = {} ##container for the current question
var TurnsTaken = 0
var gameended

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
	
	if CurrentQuestionIndex == 10:
		print("Game end")
		gameended = true
	

func OnButton1Pressed() -> void:
	CheckAnswer(Button1.text)


func OnButton2Pressed() -> void:
	CheckAnswer(Button2.text)


func OnButton3Pressed() -> void:
	CheckAnswer(Button3.text)


func OnButton4Pressed() -> void:
	CheckAnswer(Button4.text)
