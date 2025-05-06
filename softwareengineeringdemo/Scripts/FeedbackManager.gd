extends Node

class_name feedbackgen

static func FeedbackReaction(score : float) -> String:
	var feedback = ""
	if score == 0:
		feedback = "INVALID SCORE"
		return feedback
	if score >= 0.2 && score < 0.4:
		feedback = "Lighting fast reflexes! you seem incredibly alert and awake!"
		return feedback
	if score >= 0.4 && score < 0.9:
		feedback = "Quick reflexes! you seem alert and awake!"
		return feedback
	if score >= 0.9 && score < 2.0:
		feedback = "Good reflexes! you seem decently alert today!"
		return feedback
	if score >=2.0 && score <5.0:
		feedback = "Your reflexes seem a little slow today, maybe you need some more rest"
		return feedback
	else:
		feedback = "Your reflexes seem slow today, you may be quite fatigued and need rest"
		return feedback

static func FeedbackFocus(score : int) -> String:
	var feedback = ""
	if score == 0:
		feedback = "INVALID SCORE"
		return feedback
	if score <= 10 && score > 8:
		feedback = "Sharp focus today! you seem incredibly alert and awake!"
		return feedback
	if score <= 8 && score > 6:
		feedback = "Great focus! you seem alert and awake!"
		return feedback
	if score <= 6 && score > 4:
		feedback = "Good focus! you seem decently alert today!"
		return feedback
	if score <=4 && score > 2:
		feedback = "Your focus seem a little off today, maybe you need some more rest"
		return feedback
	else:
		feedback = "Your focus seems poor today, you may be quite fatigued and need rest"
		return feedback
