extends Node2D

var HowManyFlipped = 0
var TurnsTaken = 0
var SelectedCard = ""
var FlippedButtons = []
var PairsLeft = 18

##originals
##aces
@onready var AceOfClubs = $"Buttons/AceOfClubsButton"
@onready var AceOfDiamonds = $"Buttons/AceOfDiamondsButton"
@onready var AceOfHearts = $"Buttons/AceOfHeartsButton"
@onready var AceOfSpades = $"Buttons/AceOfSpadesButton"
##kings
@onready var KingOfClubs = $"Buttons/KingOfClubsButton"
@onready var KingOfDiamonds = $"Buttons/KingOfDiamondsButton"
@onready var KingOfHearts = $"Buttons/KingOfHeartsButton"
@onready var KingOfSpades = $"Buttons/KingOfSpadesButton"
##queens
@onready var QueenOfClubs = $"Buttons/QueenOfClubsButton"
@onready var QueenOfDiamonds = $"Buttons/QueenOfDiamondsButton"
@onready var QueenOfHearts = $"Buttons/QueenOfHeartsButton"
@onready var QueenOfSpades = $"Buttons/QueenOfSpadesButton"
##jacks
@onready var JackOfClubs = $"Buttons/JackOfClubsButton"
@onready var JackOfDiamonds = $"Buttons/JackOfDiamondsButton"
@onready var JackOfHearts = $"Buttons/JackOfHeartsButton"
@onready var JackOfSpades = $"Buttons/JackOfSpadesButton"
##jokers
@onready var JokerRed = $"Buttons/JokerRedButton"
@onready var JokerBlack = $"Buttons/JokerBlackButton"

##alternatives
##aces
@onready var AceOfClubsAlt = $"Buttons/AceOfClubsButton2"
@onready var AceOfDiamondsAlt = $"Buttons/AceOfDiamondsButton2"
@onready var AceOfHeartsAlt = $"Buttons/AceOfHeartsButton2"
@onready var AceOfSpadesAlt = $"Buttons/AceOfSpadesButton2"
##kings
@onready var KingOfClubsAlt = $"Buttons/KingOfClubsButton2"
@onready var KingOfDiamondsAlt = $"Buttons/KingOfDiamondsButton2"
@onready var KingOfHeartsAlt = $"Buttons/KingOfHeartsButton2"
@onready var KingOfSpadesAlt = $"Buttons/KingOfSpadesButton2"
##queens
@onready var QueenOfClubsAlt = $"Buttons/QueenOfClubsButton2"
@onready var QueenOfDiamondsAlt = $"Buttons/QueenOfDiamondsButton2"
@onready var QueenOfHeartsAlt = $"Buttons/QueenOfHeartsButton2"
@onready var QueenOfSpadesAlt = $"Buttons/QueenOfSpadesButton2"
##jacks
@onready var JackOfClubsAlt = $"Buttons/JackOfClubsButton2"
@onready var JackOfDiamondsAlt = $"Buttons/JackOfDiamondsButton2"
@onready var JackOfHeartsAlt = $"Buttons/JackOfHeartsButton2"
@onready var JackOfSpadesAlt = $"Buttons/JackOfSpadesButton2"
##jokers
@onready var JokerRedAlt = $"Buttons/JokerRedButton2"
@onready var JokerBlackAlt = $"Buttons/JokerBlackButton2"             


func FlipCard(ButtonName: TextureButton, CardName: String):
	ButtonName.visible = false
	FlippedButtons.append(ButtonName)
	
	if HowManyFlipped == 0:
		SelectedCard = CardName
		HowManyFlipped += 1	
	elif HowManyFlipped == 1:
		if SelectedCard == CardName:
			TurnsTaken += 1
			HowManyFlipped = 0
			DisableButton()
			
		else:
			TurnsTaken += 1
			HowManyFlipped = 0
			UnflipCard()
		

func UnflipCard():
	await get_tree().create_timer(0.1).timeout
	for x in FlippedButtons:
		x.visible = true	
	FlippedButtons.clear()		

func DisableButton():
	for x in FlippedButtons:
		x.disabled = true
	FlippedButtons.clear()
	PairsLeft -= 1
	if PairsLeft == 0:
		print("GameOver")


func AceOfClubsPressed() -> void:
	FlipCard(AceOfClubs, "AceOfClubs")
	


func AceOfDiamondsPressed() -> void:
	FlipCard(AceOfDiamonds, "AceOfDiamonds")


func AceOfHeartsPressed() -> void:
	FlipCard(AceOfHearts, "AceOfHearts")


func AceOfSpadesPressed() -> void:
	FlipCard(AceOfSpades, "AceOfSpades")


func KingOfClubsPressed() -> void:
	FlipCard(KingOfClubs, "KingOfClubs")


func KingOfDiamondsPressed() -> void:
	FlipCard(KingOfDiamonds, "KingOfDiamonds")


func KingOfHeartsPressed() -> void:
	FlipCard(KingOfHearts, "KingOfHearts")


func KingOfSpadesPressed() -> void:
	FlipCard(KingOfSpades, "KingOfSpades")


func QueenOfClubsPressed() -> void:
	FlipCard(QueenOfClubs, "QueenOfClubs")


func QueenOfDiamondsPressed() -> void:
	FlipCard(QueenOfDiamonds, "QueenOfDiamonds")


func QueenOfHeartsPressed() -> void:
	FlipCard(QueenOfHearts, "QueenOfHearts")


func QueenOfSpadesPressed() -> void:
	FlipCard(QueenOfSpades, "QueenOfSpades")


func JackOfClubsPressed() -> void:
	FlipCard(JackOfClubs, "JackOfClubs")


func JackOfDiamondsPressed() -> void:
	FlipCard(JackOfDiamonds, "JackOfDiamonds")


func JackOfHeartsPressed() -> void:
	FlipCard(JackOfHearts, "JackOfHearts")


func JackOfSpadesPressed() -> void:
	FlipCard(JackOfSpades, "JackOfSpades")


func JokerRedPressed() -> void:
	FlipCard(JokerRed, "JokerRed")


func JokerBlackPressed() -> void:
	FlipCard(JokerBlack, "JokerBlack")


##alt inputs

func AceOfClubsAltPressed() -> void:
	FlipCard(AceOfClubsAlt, "AceOfClubs")


func AceOfDiamondsAltPressed() -> void:
	FlipCard(AceOfDiamondsAlt, "AceOfDiamonds")


func AceOfHeartsAltPressed() -> void:
	FlipCard(AceOfHeartsAlt, "AceOfHearts")


func AceOfSpadesAltPressed() -> void:
	FlipCard(AceOfSpadesAlt, "AceOfSpades")


func KingOfClubsAltPressed() -> void:
	FlipCard(KingOfClubsAlt, "KingOfClubs")


func KingOfDiamondsAltPressed() -> void:
	FlipCard(KingOfDiamondsAlt, "KingOfDiamonds")


func KingOfHeartsAltPressed() -> void:
	FlipCard(KingOfHeartsAlt, "KingOfHearts")


func KingOfSpadesAltPressed() -> void:
	FlipCard(KingOfSpadesAlt, "KingOfSpades")


func QueenOfClubsAltPressed() -> void:
	FlipCard(QueenOfClubsAlt, "QueenOfClubs")



func QueenOfDiamondsAltPressed() -> void:
	FlipCard(QueenOfDiamondsAlt, "QueenOfDiamonds")


func QueenOfHeartsAltPressed() -> void:
	FlipCard(QueenOfHeartsAlt, "QueenOfHearts")


func QueenOfSpadesAltPressed() -> void:
	FlipCard(QueenOfSpadesAlt, "QueenOfSpades")


func JackOfClubsAltPressed() -> void:
	FlipCard(JackOfClubsAlt, "JackOfClubs")


func JackOfDiamondsAltPressed() -> void:
	FlipCard(JackOfDiamondsAlt, "JackOfDiamonds")


func JackOfHeartsAltPressed() -> void:
	FlipCard(JackOfHeartsAlt, "JackOfHearts")


func JackOfSpadesAltPressed() -> void:
	FlipCard(JackOfSpadesAlt, "JackOfSpades")


func JokerRedAltPressed() -> void:
	FlipCard(JokerRedAlt, "JokerRed")


func JokerBlackAltPressed() -> void:
	FlipCard(JokerBlackAlt, "JokerBlack")
