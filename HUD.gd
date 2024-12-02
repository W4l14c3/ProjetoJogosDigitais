extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _process(delta):
	if (ScriptGlobal.qtd_vidas==1):
		$AnimationPlayer.play("UmaVida")
	elif (ScriptGlobal.qtd_vidas==2):
		$AnimationPlayer.play("DuasVidas")
	elif (ScriptGlobal.qtd_vidas==3):
		$AnimationPlayer.play("TrêsVidas")
	elif (ScriptGlobal.qtd_vidas==4):	
		$AnimationPlayer.play("FullLife")

	if (ScriptGlobal.qtd_vidas<=0):	
		get_tree().change_scene("res://GameOver.tscn")	


