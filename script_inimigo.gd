extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var velocidade = 100
var direcao = 1
var forca_gravidade = 30
var mov = Vector2.ZERO

func _process(delta):
	mov.y += forca_gravidade
	if(not $RayCast2D2Direito.is_colliding()):
		direcao = -1
		$AnimatedSprite.flip_h = true
		
	if(not $RayCast2D2Esquerdo.is_colliding()):
		direcao = 1
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.animation("")
		
	if (direcao == 1):
		mov.x = velocidade
	elif(direcao == -1):
		mov.x = -velocidade
	
	mov = move_and_slide(mov)
