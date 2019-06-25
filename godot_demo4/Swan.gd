extends Sprite

# 速度常量
const SPEED = 100
# 最左边界和最右边界
var borderRight = 800 # 角色运动右边界
var borderLeft = -100 # 左边界


func _process(delta):
    position.x -= SPEED * delta
    # 如果天鹅飞到左边边界，把它的x坐标置为最右边界
    if position.x < borderLeft:
        position.x = borderRight

