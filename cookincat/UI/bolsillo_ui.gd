extends Panel

@onready var backgroundSprite: Sprite2D=$Background
@onready var itemSprite :Sprite2D= $Item

#Funcion a la que le pasamos un Item
func _update(item:Item): 
	#no hay ningun item en el slot
	if item==null:
		itemSprite.visible=false
	
	#hay un item en el slot
	else:
		itemSprite.visible=true
		itemSprite.texture=item.texture #la textura del item del slot se vuelve la del item que cargamos en este
