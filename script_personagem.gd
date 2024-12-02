extends KinematicBody2D


var velocidade = 150
var gravidade = 10
var forca_pulo = 275
var mov = Vector2.ZERO
var pulando = false
var atack = false
var tipo_golpe = 1
var podeMover = true
var currentAnimation = ""
var AttackSpin = 2
var DoubleAttack = 4
var dano = 0

func _process(delta):
	movimento()
	
	
#FUNÇÕES GENERICAS ABAIXO:
func movimento():
	#Função para movimento e queda...
	mov.x = 0
	mov.y += gravidade
	if(podeMover):
		if(Input.is_action_pressed("ui_right")):
			mov.x = +velocidade
			$AnimatedSprite.flip_h = false

		elif(Input.is_action_pressed("ui_left")):
			mov.x = -velocidade
			$AnimatedSprite.flip_h = true
			
		if(Input.is_action_just_pressed("ui_up") and is_on_floor()):
			mov.y =- forca_pulo
		
		if(is_on_floor()):
			pulando = false
			if (not atack):# SE NÃO ESTIVER ATACANDO ENTRA NO IF.
				if(mov.x == 0):# se movimento eixo x for 0 aniimaçãoo idle
					$AnimatedSprite.play("Idle")
				else:
					$AnimatedSprite.play("Run")
					
				if(Input.is_action_just_pressed("AtaqueGiratorio")):
					atack = true
					podeMover = false
					$RangeAttack1.get_node("CollisionShape2D").disabled = false
					$AnimatedSprite.play("AttackSpin")
					currentAnimation = "AttackSpin"
					dano = AttackSpin
				elif(Input.is_action_just_pressed("AtaqueDuplo")):
					$RangeAttack2.get_node("CollisionShape2D").disabled = false
					$AnimatedSprite.play("DoubleAttack")
					currentAnimation = "DoubleAttack"
					podeMover = false
					atack = true
					dano = DoubleAttack
			
		elif(not pulando and mov.y < -40):#Se o personagem ja não pulou
			print(mov.y)
			pulando = true
			atack = false
			$AnimatedSprite.play("Jump")
		elif(mov.y >= 10 and mov.y <= 170):
			$AnimatedSprite.play("SpinAfterJump")
		elif(mov.y >= 200):
			$AnimatedSprite.play("Fall")
		
		mov = move_and_slide(mov,Vector2(0, -1))
		
		if(global_position.y > $Camera2D.limit_bottom):
			ScriptGlobal.reset()
			get_tree().reload_current_scene()


func animacaofinalizada():
	
	podeMover = true
	atack = false # Replace with function body.
	if currentAnimation == "AttackSpin":
		if $RangeAttack1.get_node("CollisionShape2D").disabled == false:
			$RangeAttack1.get_node("CollisionShape2D").disabled = true
	elif currentAnimation == "DoubleAttack":
		if $RangeAttack2/CollisionShape2D.disabled == false:
			$RangeAttack2/CollisionShape2D.disabled = true
		

func rangeAttackSpin(body):
	print(dano)
	if body.name == "inimigo1":
		if atack:
			ScriptGlobal.takeAHit1 = true
			ScriptGlobal.mob_Vida1 -= dano
			ScriptGlobal.personagem = 1
			print (ScriptGlobal.mob_Vida1)
	elif body.name == "inimigo2":
		if atack:
			ScriptGlobal.takeAHit2 = true
			ScriptGlobal.mob_Vida2 -= dano
			ScriptGlobal.personagem = 1
			print (ScriptGlobal.mob_Vida2)
			
	elif body.name == "inimigo3":
		if atack:
			ScriptGlobal.takeAHit3 = true
			ScriptGlobal.mob_Vida3 -= dano
			ScriptGlobal.personagem = 1
			print (ScriptGlobal.mob_Vida3)


func rangeAttack2(body):
	print(dano)
	if body.name == "inimigo1":
		if atack:
			ScriptGlobal.takeAHit1 = true
			ScriptGlobal.mob_Vida1 -= dano
			print (ScriptGlobal.mob_Vida1)
	elif body.name == "inimigo2":
		if atack:
			ScriptGlobal.takeAHit2 = true
			ScriptGlobal.mob_Vida2 -= dano
			print (ScriptGlobal.mob_Vida2)
			
	elif body.name == "inimigo3":
		if atack:
			ScriptGlobal.takeAHit3 = true
			ScriptGlobal.mob_Vida3 -= dano
			print (ScriptGlobal.mob_Vida3)
