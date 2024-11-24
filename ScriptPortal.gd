extends Area2D


var portalOpen = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func MudarMapa(body):
	if(portalOpen):
		if(body.name == "Personagem"):
			get_tree().change_scene("res://Fase-2.tscn")


func OpenPortal(body):
	portalOpen = true


func ClosePortal(body):
	pass # Replace with function body.
