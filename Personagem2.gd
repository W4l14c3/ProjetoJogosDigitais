extends KinematicBody2D


var velocidade = 190
var gravidade = 8
var forca_pulo = 275
var mov = Vector2.ZERO
var pulando = false
var atack = false
var tipo_golpe = 1
var podeMover = true
var currentAnimation = ""
var attack = 1
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
	
		if(is_on_floor()):# se estiver no chão.
			pulando = false #Define pulando como falso.
			if (not atack):# SE NÃO ESTIVER ATACANDO ENTRA NO IF.
				if(mov.x == 0):# se movimento eixo x for 0 aniimaçãoo idle
					$AnimatedSprite.play("idle")
				else:
					$AnimatedSprite.play("run")
					
				if(Input.is_action_just_pressed("ui_accept")):
					$espada.play()
					atack = true
					podeMover = false
					$RangeAttack1.get_node("CollisionShape2D").disabled = false
					$AnimatedSprite.play("Attack")
					currentAnimation = "Attack"
					dano = attack
					
		elif(not pulando and mov.y < -40):
			print(mov.y)
			pulando = true
			atack = false
			$AnimatedSprite.play("jump")
		elif(mov.y >= 100):
			$AnimatedSprite.play("fall")
		
		if(global_position.y > $Camera2D.limit_bottom):
			ScriptGlobal.reset()
			get_tree().reload_current_scene()
		mov = move_and_slide(mov,Vector2(0, -1))


func animationAtack():
	podeMover = true
	atack = false # Replace with function body.
	if currentAnimation == "Attack":
		if $RangeAttack1.get_node("CollisionShape2D").disabled == false:
			$RangeAttack1.get_node("CollisionShape2D").disabled = true
			
func rangeAttack(body):
	print(dano)
	if body.name == "inimigo1":
		if atack:
			ScriptGlobal.takeAHit1 = true
			ScriptGlobal.mob_Vida1 -= dano
			ScriptGlobal.personagem = 2
			print (ScriptGlobal.mob_Vida1)
	elif body.name == "inimigo2":
		if atack:
			ScriptGlobal.takeAHit2 = true
			ScriptGlobal.mob_Vida2 -= dano
			ScriptGlobal.personagem = 2
			print (ScriptGlobal.mob_Vida2)
			
	elif body.name == "inimigo3":
		if atack:
			ScriptGlobal.takeAHit3 = true
			ScriptGlobal.mob_Vida3 -= dano
			ScriptGlobal.personagem = 2
			print (ScriptGlobal.mob_Vida3)
