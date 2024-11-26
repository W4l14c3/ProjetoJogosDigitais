extends Area2D

var velocidade = 5
var queda = -2
var direcao = 1   # 1 é direita, -1 é esquerda
var mov = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (direcao==1):
		$AnimatedSprite.flip_h = false
		global_position.x += (velocidade * direcao)
		global_position.y += (-queda * direcao)
	elif (direcao==-1):
		$AnimatedSprite.flip_h = true     
		global_position.x += (velocidade * direcao)
		global_position.y += (queda * direcao)
#		

#		
		
	
