extends KinematicBody2D


var velocidade = 150
var gravidade = 16
var forca_pulo = 275
var mov = Vector2.ZERO
var pulando = false
var atack = false

func _process(delta):
	movimento()
	
#FUNÇÕES GENERICAS ABAIXO:
func movimento():
	#Função para movimento e queda...
	mov.x = 0
	mov.y += gravidade
	
	if(Input.is_action_pressed("ui_right")):
		mov.x = +velocidade
		$Sprite.flip_h = false

	elif(Input.is_action_pressed("ui_left")):
		mov.x = -velocidade
		$Sprite.flip_h = true
		
	if(Input.is_action_just_pressed("ui_up") and is_on_floor()):
		mov.y =- forca_pulo
	
	if(is_on_floor()):
		pulando = false
		if (not atack):# SE NÃO ESTIVER ATACANDO ENTRA NO IF.
			if(mov.x == 0):# se movimento eixo x for 0 aniimaçãoo idle
				$AnimationPlayer.play("idle")
			else:
				$AnimationPlayer.play("Run")
				
			if(Input.is_action_just_pressed("AtaqueGiratorio")):
				atack = true
				$AnimationPlayer.play("AttackSpin")
			elif(Input.is_action_just_pressed("AtaqueDuplo")):
				atack = true
				$AnimationPlayer.play("DoubleAttack")
			
		if($AnimationPlayer.current_animation == ""):
			atack = false
	elif(not pulando):
		pulando = true
		atack = false
		$AnimationPlayer.play("pulo")
	
	mov = move_and_slide(mov,Vector2(0, -1))
