extends Area2D

signal score

var in_attack_zone = false

var can_score = true
var scored_points = 0

export var speed = 400 
var screen_size
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		$CraneRightAnimation.flip_h = true
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		$CraneRightAnimation.flip_h = false
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	if position.x > screen_size.x:
		position.x = 0
	if position.x < 0:
		position.x = screen_size.x

	if Input.is_action_pressed("flip-right"):
		$CraneRightAnimation.animation = "flip"
	if Input.is_action_just_released("flip-right"):
		$CraneRightAnimation.animation = "default"
	
	if in_attack_zone && Input.is_action_pressed("flip-right"):
		emit_signal("score")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_CraneRight_area_entered(area):
	print("in_attack_zone = true")
	#$CollisionShape2D.set("disabled", true)
	in_attack_zone = true

func _on_CraneRight_area_exited(area):
	print("in_attack_zone = false")
	in_attack_zone = false
	#$CollisionShape2D.set_deferred("disabled", false)
