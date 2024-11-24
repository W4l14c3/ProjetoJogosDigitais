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
var dirAtivo = false
var esqAtivo = false
var perseguicao = false

func _process(delta):
	movimentoAle()
	seguindoAdversario()
	
	
	
func seguindoAdversario():
	"""
	Veirfica se a variavel perseguição é verdadeira, se sim, vai verificar qual 
	das variaveis (dirAtivo) ou (esqAtivo) são verdadeiras para fazer o inimigo 
	perseguir o Personagem.
	
	A Velocidade na perseguição e maior 
	"""
	if(perseguicao):
		mov.y += forca_gravidade
		if(dirAtivo):
			if(not $RayCast2D2Direito.is_colliding()):
#				mov.x = 0
#				$AnimatedSprite.play("Idle")
				perseguicao = false
			else:
				direcao = 1
				$AnimatedSprite.flip_h = false
				$AnimatedSprite.play("Walk")
		
		elif(esqAtivo):
			if(not $RayCast2D2Esquerdo.is_colliding()):
#				mov.x = 0
#				$AnimatedSprite.play("Idle")
				perseguicao = false
			else:
				direcao = -1
				$AnimatedSprite.flip_h = true
				$AnimatedSprite.play("Walk")
			
		if (direcao == 1):
			mov.x = velocidade + 45
		elif(direcao == -1):
			mov.x = -velocidade - 45
		mov = move_and_slide(mov)
	
	
func movimentoAle():
	"""
	Verifica se a variavel (movAleAtivo) é verdadeira, se sim, verifica se o 
	tempo passado na propriedade Timer é menor que 7, se sim, o inimigo ficará
	imovel em (Idle), caso contrario verifica se o tempo é maior que 7, se sim, 
	o inimigo ficará se movendo(Run) no mapa até encontrar um abismo e inverter sua 
	rota.
	"""
	if(movAleAtivo):
		mov.y += forca_gravidade
		if(round($Timer.time_left) < 7):
			$AnimatedSprite.play("Idle")
			mov.x = 0
			
		elif(round($Timer.time_left) > 7):
			$AnimatedSprite.play("Walk")
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
	


"""As funções abaixo detectão se o (Personagem) esta dentro ou fora do alcance."""

func ZonaDeDeteccaoDireita(body):
	if(body.name == "Personagem"):
		perseguicao = true
		mov.x = 0
		dirAtivo = true
		movAleAtivo = false

func ZonaDeDeteccaoEsquerda(body):
	if(body.name == "Personagem"):
		perseguicao = true
		mov.x = 0
		esqAtivo = true
		movAleAtivo = false
	

func ZonaDeDeteccaoDirOut(body):
	if(body.name == "Personagem"):
		perseguicao = false
		movAleAtivo = true
		dirAtivo = false
		direcao = 1


func ZonaDeDeteccaoEsqOut(body):
	if(body.name == "Personagem"):
		perseguicao = false
		movAleAtivo = true
		esqAtivo = false
		direcao = -1

"""Fim das funções de detecção"""
