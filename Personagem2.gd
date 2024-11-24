extends KinematicBody2D


var velocidade = 150
var gravidade = 10
var forca_pulo = 275
var mov = Vector2.ZERO
var pulando = false
var atack = false
var tipo_golpe = 1
var podeMover = true

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
					atack = true
					podeMover = false
					$AnimatedSprite.play("Atack")
			if(atack):
	#			print("Ataque acabou")
	#			atack = false
				pass
		elif(not pulando and mov.y < -40):
			print(mov.y)
			pulando = true
			atack = false
			$AnimatedSprite.play("jump")
		elif(mov.y >= 100):
			$AnimatedSprite.play("fall")
		
		if(global_position.y > $Camera2D.limit_bottom):
	#		ScriptGlobal.reset()
			get_tree().reload_current_scene()
		mov = move_and_slide(mov,Vector2(0, -1))


func animationAtack():
	podeMover = true
	atack = false
