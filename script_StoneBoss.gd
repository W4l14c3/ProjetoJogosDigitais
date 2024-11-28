extends KinematicBody2D


var velocidade = 50

var direcao = 1
var forca_gravidade = 30
var mov = Vector2.ZERO
var movAleAtivo = true
var dirAtivo = false
var esqAtivo = false
var perseguicao = false
var stoneAttack = false
var meleeAttack = false
var rangeAttackEsq = false
var rangeAttackDir = false
var laserCast = false
var laserBeanAttack = false
var laserCarregado = false
var atacando = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()

	pass # Replace with function body.
	



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
				if not atacando:
					$AnimatedSprite.play("Run")
		
		elif(esqAtivo):
			if(not $RayCast2D2Esquerdo.is_colliding()):
#				mov.x = 0
#				$AnimatedSprite.play("Idle")
				perseguicao = false
			else:
				direcao = -1
				$AnimatedSprite.flip_h = true
				if not atacando:
					$AnimatedSprite.play("Run")
			
		if (direcao == 1):
			mov.x = velocidade + 60
		elif(direcao == -1):
			mov.x = -velocidade - 60
		mov = move_and_slide(mov)
	
	
func movimentoAle():
	"""
	Verifica se a variavel (movAleAtivo) é verdadeira, se sim, verifica se o 
	tempo passado na propriedade Timer é menor que 7, se sim, o inimigo ficará
	imovel em (Idle), caso contrario verifica se o tempo é maior que 7, se sim, 
	o inimigo ficará se movendo(Run) no mapa até encontrar um abismo e inverter sua 
	rota.
	"""
	if not atacando:
		if(movAleAtivo):
			$AnimatedSprite.play("Idle")
			stoneAttack = false
			
			mov.y += forca_gravidade
			if(round($Timer.time_left) < 7):
				mov.x = 0
				$AnimatedSprite.play("Idle")
				
			elif(round($Timer.time_left) > 7):
					
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
	


#func rangedAttack():
#	if(not stoneAttack):
#		print("Atirou")
#		if(rangeAttackEsq):
#			stoneAttack = true
#			print("Esquerda")
#			direcao = 1
#			$AnimatedSprite.flip_h = false
#			if not atacando:
#				$AnimatedSprite.play("RangeAttack")
#		elif(rangeAttackDir):
#			stoneAttack = true
#			print("Direita")
#			direcao = -1
#			$AnimatedSprite.flip_h = false
#			if not atacando:
#				$AnimatedSprite.play("RangeAttack")

"""As funções abaixo detectão se o (Personagem) esta dentro ou fora do alcance."""

func ZonaDeDeteccaoDireita(body):
	if(body.name == "Personagem"):
		perseguicao = true
		mov.x = 0
		dirAtivo = true
		movAleAtivo = false
		meleeAttack = false

func ZonaDeDeteccaoEsquerda(body):
	if(body.name == "Personagem"):
		perseguicao = true
		mov.x = 0
		esqAtivo = true
		movAleAtivo = false
		meleeAttack = false
	

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

"""Funções de Ataque"""

func carregaDisparo():
	if(stoneAttack):
		print(stoneAttack)
		var cena_disparo = preload("res://StoneProjectile.tscn")
		var obj_disparo  = cena_disparo.instance()
		
		get_tree().root.add_child(obj_disparo)
		
		if (direcao==1):
			obj_disparo.global_position = $Position2DDir.global_position
			
		elif (direcao==-1):
			obj_disparo.global_position = $Position2DEsq.global_position
		
		obj_disparo.get_node("Area2D").direcao = direcao
	
	if(laserBeanAttack):
		print("Disparou")
		if (direcao==1):
			$LaserBeanDir.play("LaserBean")
			$LaserBeanDir.visible = true
			$LaserBeanEsq.visible = false
			
		elif (direcao==-1):
			$LaserBeanDir.play("LaserBean")
			$LaserBeanDir.visible = false
			$LaserBeanEsq.visible = true
			
	else:
		$LaserBeanDir.visible = false
		$LaserBeanEsq.visible = false


"""Funções ataque Ranged"""
func onRangedAttackEsq(body):
	if(body.name == "Personagem"):
		if(not stoneAttack):
#			rangedAttack()
			stoneAttack = true
			#rangeAttackEsq = true
			movAleAtivo = false
			direcao = -1
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("RangeAttack")
			atacando = true


func onRangedAttackDir(body):
	if(body.name == "Personagem"):
		if(not stoneAttack):
#			rangedAttack()
			stoneAttack = true
			#rangeAttackDir = true
			movAleAtivo = false
			direcao = 1
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("RangeAttack")
			atacando = true


func offRangeAttackEsq(body):
	if(body.name == "Personagem"):
#		stoneAttack = false
		rangeAttackEsq = false
		atacando = false
		#movAleAtivo = true


func offRangeAttackDir(body):
	if(body.name == "Personagem"):
#		stoneAttack = false
		rangeAttackDir = false
		atacando = false
		#movAleAtivo = true
		
		
"""Fim funções ataque Ranged"""

"""Funções ataque melee"""
func onMeleeAttackRangeDir(body):
	
	if(body.name == "Personagem"):
		perseguicao = false
		movAleAtivo = false
		mov.x = 0
		stoneAttack = false
		direcao = 1
		$AnimatedSprite.flip_h = false
		
		if(not meleeAttack):
			
			meleeAttack = true
			#rangeAttackDir = true
			$AnimatedSprite.play("Melee")
			atacando = true


func onMeleeAttackRangeEsq(body):
	
	if(body.name == "Personagem"):
		print("Na mira")
		perseguicao = false
		movAleAtivo = false
		mov.x = 0
		stoneAttack = false
		direcao = -1
		$AnimatedSprite.flip_h = true
		
		if(not meleeAttack):
			
			meleeAttack = true
			#rangeAttackDir = true
			$AnimatedSprite.play("Melee")
			atacando = true

func offMeleeAttackDir(body):
	if(body.name == "Personagem"):
		movAleAtivo = true
		meleeAttack = false
		atacando = false
		


func offMeleeAttackEsq(body):
	if(body.name == "Personagem"):
		movAleAtivo = true
		meleeAttack = false
		atacando = false
"""Fim funções ataque melee"""

"""Fim das funções de ataque"""

func _on_AnimatedSprite_animation_finished():
	if ($AnimatedSprite.animation=="RangeAttack"):
		stoneAttack = true
		carregaDisparo()
		atacando = false
		movAleAtivo = true





func onLaserAttackDir(body):

	
	if(body.name == "Personagem"):
		perseguicao = false
		movAleAtivo = false
		stoneAttack = false
		mov.x = 0
		direcao = 1
		$AnimatedSprite.flip_h = false
		$LaserCast.flip_h = true
		
		if(not laserCast):
			laserCast = true
			$LaserCast.visible = true
			$AnimatedSprite.play("LaserCast")
			$LaserCast.play("LaserCast")
			laserBeanAttack = true
			
			atacando = true

func onLaserAttackEsq(body):
	
	if(body.name == "Personagem"):
		perseguicao = false
		movAleAtivo = false
		stoneAttack = false
		mov.x = 0
		direcao = -1
		$AnimatedSprite.flip_h = true
		$LaserCast.flip_h = false
		
		if(not laserCast):
			laserCast = true
			$LaserCast.visible = true
			$AnimatedSprite.play("LaserCast")
			$LaserCast.play("LaserCast")
			laserBeanAttack = true
			
			atacando = true




func offLaserAttackDir(body):
	if(body.name == "Personagem"):
		$LaserBeanDir.visible = false
		$LaserBeanEsq.visible = false
		movAleAtivo = true
		laserCast = false
		laserBeanAttack = false
		atacando = false
		$LaserCast.visible = false
		


func offLaserAttackEsq(body):
	if(body.name == "Personagem"):
		$LaserBeanDir.visible = false
		$LaserBeanEsq.visible = false
		movAleAtivo = true
		laserCast = false
		laserBeanAttack = false
		atacando = false
		$LaserCast.visible = false




func laserBeanAnimationFinished():
#	$LaserBeanDir.visible = false
#	$LaserBeanEsq.visible = false
#	laserBeanAttack = false
#	movAleAtivo = true
	pass


func _on_LaserCast_animation_finished():
	if ($LaserCast.animation=="LaserCast"):
		
		carregaDisparo()
		atacando = false

