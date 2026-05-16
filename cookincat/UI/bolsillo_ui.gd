extends Control

class_name Bolsillo_UI

var bolsillo:Bolsillo


@onready var item :Item #item que contiene el bolsillo UI (nos servira para conocer la info de este al pasarlo al slothueto
@onready var itemSprite :TextureRect=$CenterContainer/IconoItem
@onready var itemCantidad:Label=$Label_Cantidad#texto con la cantidad de ese item

var _is_dragging := false
var _current_drag_item: Item = null
@export var current_drag_bolsillo: Bolsillo


	

func is_currently_dragging() -> bool:
	return _is_dragging
	
func get_current_drag_item() -> Item:
	return _current_drag_item

func _ready() -> void:
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND #cambo el dibujo del raton
	

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
		item=bolsillo.item #asi puedo acceder a la inmformacion del uitem quje se encuentra en bolsillo/bolsiiloUi
		itemSprite.texture=load(bolsillo.item.icon_texture_path)
		itemCantidad.text=str(bolsillo.cantidad)



#funcion llamada cuando haces click y empiezas a desplazar (devuelves los datos de lo que quieres mover)
func _get_drag_data(at_position: Vector2) -> Variant:
	if bolsillo.item.tipo=="Semilla": #si es de tippo semilla se puede arrastrar
		#si no esta sobre ninguna textura(celda)
		if bolsillo == null or bolsillo.item == null:
			return
			
		
		
		print ("bolsillo que arrastamos->",bolsillo.id_bolsillo)
		
		#Lo cargo EN EL AUTOLOAD no en el nodo (para que se quede y no me devuelva null)
		BolsilloUi._is_dragging = true
		BolsilloUi._current_drag_item = bolsillo.item
		BolsilloUi.current_drag_bolsillo = bolsillo
		
		
		
		print("current item ",BolsilloUi._current_drag_item)
		
		print("dag detectafdom")
		
		#cuando arrastras se muestra una preview del objeto al lado del raton (creo junto  a la textura un area 2d y un collider para detectar el slot del huerto
		var area=Area2D.new()#area preview
		var collider =CollisionShape2D.new() #colision preview
		var forma=RectangleShape2D.new()#forma de la colision
		
		
		var preview := TextureRect.new() #duplica la textura de la celda #tectura preview
		preview.texture = itemSprite.texture
		#cetnro la preview en el raton que me da toc
		preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		preview.custom_minimum_size=Vector2(80,80)
		preview.position = -preview.custom_minimum_size / 2
	
	
		collider.shape=forma
		
		#area.position= -preview.custom_minimum_size / 2
		
		print (collider)
		var c=Control.new()
		area.add_child(preview)
		area.add_child(collider)
		c.add_child(area)
		
		
		
		set_drag_preview(c) ##lo pone debajo del mouse mientras lo arrastras
		
		#le paso los datos del item que estoy arrastrando para que el slot capte sus datos y pueda acceder a estos
		return{
			"slot": self,
			"item": bolsillo.item,
			"cantidad": bolsillo.cantidad
		}
	
	return null

func _drop_data(at_position: Vector2, data: Variant) -> void: #para cuando suelta (hace el drop
	BolsilloUi._is_dragging = false
	BolsilloUi.current_drag_bolsillo = null
