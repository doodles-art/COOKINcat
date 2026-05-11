extends Control

class_name Bolsillo_UI


@onready var itemSprite :TextureRect=$CenterContainer/IconoItem
@onready var itemCantidad:Label=$Label_Cantidad #texto con la cantidad de ese item

#Funcion a la que le pasamos un Item
func _set_bolsillo(bolsillo:Bolsillo): #le paso algo de tipo Bolsillo en el que quiero meter algo
	#no hay ningun item en el slot
	if bolsillo.item ==null:
		itemSprite.visible=false
		itemCantidad.text=""
		return
	
	#hay un item en el slot
	else:
		itemSprite.visible=true
		itemSprite.texture=load(bolsillo.item.icon_texture_path)
		itemCantidad.text=str(bolsillo.cantidad)
