extends Node2D

onready var player = $Player
onready var animationPlayer = $Player/AnimationPlayer
onready var currentAnimation = 'player_down'
var speed = 200

func _ready():
	updatePlayerStatus(true, 'player_idle')
	
func _process(delta):
	var animation = currentAnimation
	var vector = Vector2(0, 0)
	var moving = false
	
	if Input.is_key_pressed(KEY_DOWN):
		vector.y += 1
		moving = true
		animation = 'player_down'
	if Input.is_key_pressed(KEY_UP):
		vector.y -= 1
		moving = true
		animation = 'player_up'
	if Input.is_key_pressed(KEY_LEFT):
		vector.x -= 1
		moving = true
		animation = 'player_left'
	if Input.is_key_pressed(KEY_RIGHT):
		vector.x += 1
		moving = true
		animation = 'player_right'
	
	if vector.length() > 0:
		player.position += vector.normalized() * speed * delta
	
	updatePlayerStatus(moving, animation)					

func updatePlayerStatus(moving, animation):
	if moving and currentAnimation != animation:
		animationPlayer.current_animation = animation
		animationPlayer.play(animation)
		currentAnimation = animation
	elif !moving and currentAnimation != 'player_idle':
		animationPlayer.stop()
		currentAnimation = 'player_idle'
			
