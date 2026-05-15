extends StaticBody2D

#este area sirve para guiar al jugador hacia donde tiene que plantar en el huerto

class_name SlotHuerto_UI
@export var slot_huerto: SlotHuerto #resource con info del huerto

@onready var icono:Panel=$Panel

var is_dragging :=false
var bolsillo_ui :BolsilloUi

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BolsilloUi.connect("Dragging",Callable(self,"_drop"))#si se envia la señal de quen un bolsillo se esta arrastrando llama a la funcion _drop
	
	
	
func _drop(bolsillo_ui_drag:BolsilloUi):
	is_dragging=true
	bolsillo_ui=bolsillo_ui_drag
	print("esta arrastrando cuidao")
	
func _on_static_body_2d_mouse_entered() -> void: #cuando el raton toque el slot ui
	print("entro al static body")
	if is_dragging==true:
		_Plantar()
	
	
	
func _Plantar():
	slot_huerto.item=bolsillo_ui.bolsillo.item #cojo el item que habia en el drag y lo guardo en el slot de mi huerto (sobre el que estaba el raton
"""
#___________________________
##SISTEMA DRAG AND DROP##
#____________________________

func _can_drop_data(at_position:Vector2, data:Variant ) ->bool:
	if not is_hovered or not data.has("item"):
		print("np")
		return false
		
	var item=data["item"]
	
	#solo acepta semillas
	return item.tipo=="semilla"
	
func _drop_data(at_position:Vector2, data: Variant)->void:
	if is_hovered==false:
		return
		
	var item=data["item"]
	var bolsillo_origen =data["slot"]
	
	#si ya hay algo plantado no planto nada
	if slot_huerto.item!=null:
		return
		
	#PLANTAR 
	slot_huerto.item=item
	slot_huerto.tiempo=item.tiempo
	#resto 1 al inventario (-1 cantidad al bolsillo=
	Inventario.bolsillo._restarItem(bolsillo_origen.id_bolsillo,1) #le resto la cantidasd de uno y ya que maneje el inventario las catnidades si tiene que quital algun bolsillo, etc...
	
	_actualizar_visual()

#______________________________
#ACTUALIZAMOS LA UI DEL SLOT
#___________________________
func _actualizar_visual():
	if slot_huerto.item==null: #no hay nada plantado
		icono.visible=true
		return
		
	#si no se cumple lo de arriba llega aquo (hay algo plantado)
	icono.visible=true
	icono.texture=load(slot_huerto.item.icon_texture_path)
"""
