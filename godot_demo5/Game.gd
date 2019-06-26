extends Node2D

onready var player = $Player
onready var animationPlayer = $AnimationPlayer
onready var camera = $Camera2D

var currentAnimation = 'player_start'
var speed = 200

func _ready():
	camera.position = player.position

func _process(delta):
	var velocity = Vector2(0, 0) # 速度变量
	var isMoving = false # 是否按键移动
	var newAnimation = currentAnimation # 动画变量
	
	if Input.is_key_pressed(KEY_LEFT):
		velocity.x += -1
		newAnimation = 'player_left'
		isMoving = true
	if Input.is_key_pressed(KEY_RIGHT):
		velocity.x += 1
		newAnimation = 'player_right'
		isMoving = true
	if Input.is_key_pressed(KEY_UP):
		velocity.y += -1
		newAnimation = 'player_up'
		isMoving = true
	if Input.is_key_pressed(KEY_DOWN):
		velocity.y += 1
		newAnimation = 'player_down'
		isMoving = true	
	# 速度不为０，移动玩家位置
	if velocity.length() > 0:
			# 注意这里normalize速度矢量，否则会出现斜着走速度比单方向走速度快
			player.position += velocity.normalized() * speed * delta
			updateCameraPosition()
			
	updateAnimation(isMoving, newAnimation)		

func updateAnimation(moving, animation):
	if moving and currentAnimation != animation:
		animationPlayer.current_animation = animation
		animationPlayer.play(animation)
		currentAnimation = animation
	elif !moving and  currentAnimation != 'player_start':
		animationPlayer.stop()
		currentAnimation = 'player_start'
		
func updateCameraPosition():
	camera.position = player.position		
