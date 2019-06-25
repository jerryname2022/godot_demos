extends Node2D

# 常量，表示速度(像素)
const SPEED = 200

var borderRight = 500 # 角色运动右边界
var borderLeft = 0 # 左边界
# onready 关键字使变量在场景加载完之后赋值，保证不为null．
onready var nodeKnight = self.get_node("Knight") # 角色节点
onready var sky1 = self.get_node("Sky1")
onready var sky2 = self.get_node("Sky2")


# Called every frame. 'delta' is the elapsed time since the previous frame.
# 每帧运行触发该方法．
func _process(delta):
	updateSkyAnimation(SPEED * delta)
	# updateSwanAnimation(SPEED * delta)
	# Input表示设备输入,这里D和右光标表示往右移动
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		moveKnightX(1, SPEED, delta)
		return
	elif Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		moveKnightX(-1, SPEED, delta)
		return	
		
	# 没有移动	
	if nodeKnight.animation != 'idle':
		nodeKnight.animation = 'idle'
			


# 处理设备输入的方法
func _input(event):
    print('input event: ', event)

# 处理设备输入的另一个方法
func _unhandled_input(event):
    print('unhandled input event: ', event)


func moveKnightX(direction, speed, delta):
	if nodeKnight.animation != 'run':
		nodeKnight.animation = 'run'
		
	if direction == 0:
		return
	nodeKnight.position += Vector2(speed, 0) * delta * direction
	# 越界检测
	if nodeKnight.position.x > borderRight:
		nodeKnight.position = Vector2(borderRight, nodeKnight.position.y)
	if nodeKnight.position.x < borderLeft:
		nodeKnight.position = Vector2(borderLeft, nodeKnight.position.y)
	# 节点的scale属性为缩放矢量
	# 缩放矢量x值为1就是往右，-1表示往左缩放
	nodeKnight.scale = Vector2(direction, 1)
	
func updateSwanAnimation(speed):
    if $Swan.frame == 7:
        $Swan.frame = 0
    else:
        $Swan.frame += 1


func updateSkyAnimation(speed):
	# 
	if sky1.position.x > -700:
		sky1.position.x -= speed
		sky2.position.x -= speed
	else:
		sky1.position.x = 600
		sky2.position.x = 1800