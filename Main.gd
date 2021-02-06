extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	start_new_game()
	$ResultsLabel.text = "Vasya A D to move G to flip \nTolik arrows to move keypad 0 or slash to flip\nFirst one to flip wins"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func start_new_game():
	$Crane1.position = Vector2(760,382)
	$Crane2.position = Vector2(280,386)
	$ResultsLabel.text = "FLIP"
	$Crane1/CraneRightAnimation.animation = "default"
	$Crane2/CraneLeftAnimation.animation = "default"
	$Crane1.can_score = true
	$Crane2.can_score = true
	


func _on_Crane2_score():
	$ResultsLabel.text = "Vasya scored"
	$Crane1/CraneRightAnimation.animation = "flipped"
	if $Crane2.can_score:
		$Crane2.scored_points += 1
		$Crane2.can_score = false
	$Crane2LabelScore.text = str($Crane2.scored_points)
	$StartTimer.start()

func _on_Crane1_score():
	$ResultsLabel.text = "Tolik scored"
	$Crane2/CraneLeftAnimation.animation = "flipped"
	if $Crane1.can_score:
		$Crane1.scored_points += 1
		$Crane1.can_score = false
	$Crane1LabelScore.text = str($Crane1.scored_points)
	$StartTimer.start()

func _on_Timer_timeout():
	start_new_game()

