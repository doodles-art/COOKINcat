extends Control

@onready var backgroundSprite: Sprite2D=$Background
@onready var itemSprite :Sprite2D= $Item

#Funcion a la que le pasamos un Item
func _update(bolsillo:Bolsillo): #le paso algo de tipo Bolsillo en el que quiero meter algo
	#no hay ningun item en el slot
	if bolsillo.item ==null:
		itemSprite.visible=false
		return
	
	#hay un item en el slot
	else:
		itemSprite.visible=true
		itemSprite.texture=load(bolsillo.item.icon_texture_path)
