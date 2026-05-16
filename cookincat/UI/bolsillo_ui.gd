extends Control

class_name Bolsillo_UI

var bolsillo:Bolsillo

@onready var itemSprite :TextureRect=$CenterContainer/IconoItem
@onready var itemCantidad:Label=$Label_Cantidad#texto con la cantidad de ese item

var _is_dragging := false
var _current_drag_item: Item = null
var current_drag_bolsillo: Bolsillo = null

signal dragging (bolsillo_ui:Bolsillo_UI) #señal que mando cuando se activa que se esta arrastrando el bolsilloui(y te pasa el bolsill_UI)

func is_currently_dragging() -> bool:
	return _is_dragging
	
func get_current_drag_item() -> Item:
	return _current_drag_item

func _ready() -> void:
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND #cambo el dibujo del raton
	gui_input.connect(_on_gui_input)

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


func _gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		print("CLICK DETECTADO EN BOLSILLO")

#funcion llamada cuando haces click y empiezas a desplazar (devuelves los datos de lo que quieres mover)
func _get_drag_data(at_position: Vector2) -> Variant:
	 
	#si no esta sobre ninguna textura(celda)
	if bolsillo == null or bolsillo.item == null:
		return
		
	
	
	print ("bolsillo que arrastamos->",bolsillo.id_bolsillo)
	_is_dragging = true
	_current_drag_item = bolsillo.item
	current_drag_bolsillo = bolsillo
	
	emit_signal("dragging",self) #mandamos una señal (para slot_huerto ) junto con el bolsillo que estamos arrastrando
	print("dag detectafdom")
	
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
	_is_dragging = false
	_current_drag_item = null
	current_drag_bolsillo = null
	
func _on_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			print("Click en bolsillo UI")
