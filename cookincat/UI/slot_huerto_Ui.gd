extends Control

#este area sirve para guiar al jugador hacia donde tiene que plantar en el huerto

class_name SlotHuerto_UI
@export var slot_huerto: SlotHuerto #resource con info del huerto

@onready var area: Area2D=$Area2D
@onready var icono:Panel=$Panel

var is_hovered :=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icono.visible=false
	print("Area2D pickable:", area.input_pickable)
	print("Collision shape:", area.get_child(0))
	
	#Detectamos cuando el raton sale o  entra del area del slot
	#si entra llamamos a la funcion _on_mouse_enter (dentro de su mismo codigo ->self)
	area.connect("mouse_entered",Callable(self,"_on_mouse_enter"))
	
	#si sale llamamos a ala funcion _on_mouse_exit
	area.connect("mouse_exited",Callable(self,"_on_mouse_exit"))
	
	_actualizar_visual()
	

func _on_mouse_enter(): #el raton entra en el area del slot
	is_hovered=true
	print("ENTRO")
	
func _on_mouse_exit(): #el raton sale del area del slot
	is_hovered=false
	print("SALIO")
#___________________________
##SISTEMA DRAG AND DROP##
#____________________________

func _can_drop_data(at_position:Vector2, data:Variant ) ->bool:
	if not is_hovered or not data.has("item"):
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
		icono.visible=false
		return
		
	#si no se cumple lo de arriba llega aquo (hay algo plantado)
	icono.visible=true
	icono.texture=load(slot_huerto.item.icon_texture_path)
