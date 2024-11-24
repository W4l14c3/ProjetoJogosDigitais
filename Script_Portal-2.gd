extends Node2D


var portalOpen = false
var portalAbril = false


func MudarMapa(body):
	if(portalOpen):
		
		if(body.name == "Personagem"):
			get_tree().change_scene("res://Fase-2.tscn")
			


func OpenPortal(body):
	if(body.name == "Personagem"):
		if(not portalOpen):
			portalOpen = true
			$AnimatedSprite.play("PortalOpen")
		
		


func ClosePortal(body):
	if(body.name == "Personagem"):
		portalOpen = false
		$AnimatedSprite.play("PortalDie")


func AnimacaoFinalizada():
	if(portalOpen):
		$AnimatedSprite.play("PortalLoop")
