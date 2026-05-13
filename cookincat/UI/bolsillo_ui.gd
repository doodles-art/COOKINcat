extends Control

class_name Bolsillo_UI

var bolsillo:Bolsillo

@onready var itemSprite :TextureRect=$CenterContainer/IconoItem
@onready var itemCantidad:Label=$Label_Cantidad#texto con la cantidad de ese item

#variables para el sistema de DRAG&DROP
var draggable=false #¿se puede arrastrar?
var is_inside_dropable=false #¿esta dentro de un objeto en ek que se puede dropear?
var is_dragging=false
var boddy_ref

func _ready() -> void:
	print("NODO ACTUAL:",self)
	print("HIJOS:",get_children())

#Funcion a la que le pasamos un Item
func _set_bolsillo(bolsillo:Bolsillo): #le paso algo de tipo Bolsillo en el que quiero meter algo
	self.bolsillo=bolsillo
	
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


"""
func _gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		print("CLICK DETECTADO EN BOLSILLO")

#funcion llamada cuando haces click y empiezas a desplazar (devuelves los datos de lo que quieres mover)
func _get_drag_data(at_position: Vector2) -> Variant:
	is_dragging=true 
	print("dag detectafdom")
	#si no esta sobre ninguna textura(celda)
	if bolsillo == null or bolsillo.item == null:
		return
	 
	
	#cuando arrastras se muestra una preview del objeto al lado del raton
	var preview := TextureRect.new() #duplica la textura de la celda
	preview.texture = itemSprite.texture
	#cetnro la preview en el raton que me da toc
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	preview.custom_minimum_size=Vector2(80,80)
	preview.position = -preview.custom_minimum_size / 2
	
	
	#para centrar la preview
	var c=Control.new()
	c.add_child(preview)
	
	
	set_drag_preview(c) ##lo pone debajo del mouse mientras lo arrastras
	
	#le paso los datos del item que estoy arrastrando para que el slot capte sus datos y pueda acceder a estos
	return{
		"slot": self,
		"item": bolsillo.item,
		"cantidad": bolsillo.cantidad
	}
	
#Se llama si se verifica que se este arrasrrastrando algo (y si se puede soltar o no)
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true

#Si pasa el can_drop data ocurre este (decidimos que hacer con lo que se esta arrastrando)
func _drop_data(at_position: Vector2, data: Variant) -> void:
	pass
"""
