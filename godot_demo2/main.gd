extends Node2D

# 常量，表示速度(像素)
const SPEED = 200

var borderRight = 500 # 角色运动右边界
var borderLeft = 0 # 左边界
var nodeKnight # 角色节点

# Called when the node enters the scene tree for the first time.
# 节点激活后，运行该方法．
func _ready():
	nodeKnight = self.get_node("knight")
	# borderRight -= nodeKnight.get_rect().size.x / 2
	# borderLeft += nodeKnight.get_rect().size.x / 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
# 每帧运行触发该方法．
func _process(delta):
	# Input表示设备输入,这里D和右光标表示往右移动
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		moveKnightX(1, SPEED, delta)
	elif Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		moveKnightX(-1, SPEED, delta)	
#	pass

# 处理物理引擎的方法
func _physics_process(delta):
	pass
   
# print('physics process with delta time: ', delta)

# 处理设备输入的方法
func _input(event):
    print('input event: ', event)

# 处理设备输入的另一个方法
func _unhandled_input(event):
    print('unhandled input event: ', event)


func moveKnightX(direction, speed, delta):
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