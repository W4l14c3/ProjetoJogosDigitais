extends KinematicBody2D


var velocidade = 150
var gravidade = 10
var forca_pulo = 275
var mov = Vector2.ZERO

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
		if(is_on_floor()):
			$AnimationPlayer.play("Run")
	elif(Input.is_action_pressed("ui_left")):
		mov.x = -velocidade
		$Sprite.flip_h = true
		if(is_on_floor()):
			$AnimationPlayer.play("Run")
	else:
		$AnimationPlayer.play("idle")
		
	if(Input.is_action_just_pressed("ui_up") and is_on_floor()):
		mov.y =- forca_pulo
		$AnimationPlayer.play("Jump")
	
	mov = move_and_slide(mov,Vector2(0, -1))
