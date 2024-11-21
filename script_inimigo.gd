extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	pass # Replace with function body.
	

var velocidade = 50
var direcao = 1
var forca_gravidade = 30
var mov = Vector2.ZERO
var movAleAtivo = true

func _process(delta):
	movimentoAle()
	
func movimentoAle():
	if(movAleAtivo):
		mov.y += forca_gravidade
		if(round($Timer.time_left) < 7):
			$AnimatedSprite.play("Idle")
			mov.x = 0
			
		elif(round($Timer.time_left) > 7):
			$AnimatedSprite.play("Run")
			if(not $RayCast2D2Direito.is_colliding()):
				direcao = -1
				$AnimatedSprite.flip_h = true
				
				
			if(not $RayCast2D2Esquerdo.is_colliding()):
				direcao = 1
				$AnimatedSprite.flip_h = false

			if (direcao == 1):
				mov.x = velocidade
			elif(direcao == -1):
				mov.x = -velocidade
			
			mov = move_and_slide(mov)




func ZonaDeDeteccaoDireita(body):
#	movAleAtivo = false
#	mov.x = -velocidade
#	mov = move_and_slide(mov)
	pass
#

func ZonaDeDeteccaoEsquerda(body):
#	movAleAtivo = false
#	mov.x = velocidade
#	mov = move_and_slide(mov)
	pass
