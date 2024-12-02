extends Node
#Personagem
var qtd_vidas = 4

#Mobs
var mob_Vida1 = 10
var mob_Vida2 = 10
var mob_Vida3 = 10
var takeAHit1 = false
var takeAHit2 = false
var takeAHit3 = false
var personagem = 0
#Boss
var chefe_vida = 20

func reset():
	qtd_vidas = 4
	mob_Vida1 = 10
	mob_Vida2 = 10
	mob_Vida3 = 10
