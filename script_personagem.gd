extends KinematicBody2D

var velocidade = 150
var gravidade = 10
var forca_pulo = 100
var mov = Vector2.ZERO

func _process(delta):
	movimento()
	
#FUNÇÕES GENERICAS ABAIXO:
func movimento():
	#Função para movimento e queda...
	mov.x = 0
	mov.y += gravidade
	
	while(mov.x == 0):
		$AnimationPlayer.play("idle")
	if(Input.action_press("ui_right")):
		mov.x = -velocidade
		$Sprite.flip_h = false
		$AnimationPlayer.play("Run")
	elif(Input.action_press("ui_left")):
		mov.x = +velocidade
		$Sprite.flip_h = true
		$AnimationPlayer.play("Run")
	else:
		$AnimationPlayer.play("idle")
	
