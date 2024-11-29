extends Area2D

var velocidade = 3
var queda = -1
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




func danoProjetil(body):
	if(body.name == "Personagem"):
		
		ScriptGlobal.qtd_vidas -= 1
		body.get_node("AnimationPlayer").play("DanoSofrido")
