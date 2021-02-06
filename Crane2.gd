extends Area2D

var in_attack_zone = false

signal score

var scored_points = 0
var can_score = true

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
	if Input.is_action_pressed("2nd-right"):
		velocity.x += 1
		$CraneLeftAnimation.flip_h = false
	if Input.is_action_pressed("2nd-left"):
		velocity.x -= 1
		$CraneLeftAnimation.flip_h = true
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	if position.x > screen_size.x:
		position.x = 0
	if position.x < 0:
		position.x = screen_size.x
	
	if Input.is_action_pressed("flip-left"):
		$CraneLeftAnimation.animation = "flip"
	if Input.is_action_just_released("flip-left"):
		$CraneLeftAnimation.animation = "default"
		
	if in_attack_zone && Input.is_action_pressed("flip-left"):
		emit_signal("score")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):

func _on_CraneLeft_area_entered(area):
	print("in_attack_zone = true")
	#$CollisionShape2D.set("disabled", true)
	in_attack_zone = true


func _on_CraneLeft_area_exited(area):
	print("in_attack_zone = false")
	#$CollisionShape2D.set("disabled", true)
	in_attack_zone = false
