extends Area2D

#este area sirve para guiar al jugador hacia donde tiene que plantar en el huerto

class_name SlotHuerto_UI
@export var slot_huerto: SlotHuerto #resource con info del huerto
@export var item:Item
@onready var fondo:Panel=$Panel
@onready var icono_cultivo:TextureRect=$CenterContainer/Icono
@onready var contador_tiempo:Label=$Tiempo

signal update_bolsillo

var is_dragging :=false
var bolsillo_dragged: Bolsillo = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func _process(delta: float) -> void:  #se lee casda frame
	#comprobacion para visibilizar las ayudas
	if BolsilloUi._is_dragging==true: #si se esta arrastrandose
		fondo.visible=true
	
	else:
		fondo.visible=false
		
	#compruebo si se ha actualizado el bolsilloUi
	#Slo

#Funcion a la que le pasamos un Item
func _set_slotHuerto(slot_huerto:SlotHuerto): #le paso algo de tipo Bolsillo en el que quiero meter algo
	self.slot_huerto=slot_huerto
	
	#no hay ningun item en el slot
	if slot_huerto.item ==null:
		icono_cultivo.visible=false
		contador_tiempo.text=""
		return
	
	#hay un item en el slot
	else:
		icono_cultivo.visible=true
		item=slot_huerto.item #asi puedo acceder a la inmformacion del uitem quje se encuentra en bolsillo/bolsiiloUi
		icono_cultivo.texture=load(slot_huerto.item.icon_texture_path)
		contador_tiempo.text=str(slot_huerto.tiempo)

#______________________________________
#DETECCIÓN DEL ARRASTRE DEL BOLSILLO_UI
#______________________________________________________________________________________________________________
func _on_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	print("FUERA")

func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	print ("DENTRO")
	if slot_huerto.item == null: #si el slot de huerto esta vacio puedo platar
		_plantar()
#______________________________________________________________________________________________________________

func _plantar():
#para coger la infor del bolsillo que arrastro
	var bolsillo_dragged = BolsilloUi.current_drag_bolsillo
	
	if slot_huerto.item!=null: #si en el slot hay algun item ya no plantamos nada
		return
	
	#le resto 1 al bolsillo del item que he plantado (y que el inventario y el inventario Ui se encargen del resto)
	Inventario._restarItem(BolsilloUi.current_drag_bolsillo.item.id,1)
	
	#emit_signal("update_bolsillo")
	
	#textura de plantita (esta creciendo)
	icono_cultivo.texture=load("res://Sprites/Sprout.png")
	
	#slot_huerto.item =bolsillo_ui_ref.item
	print("Item plantado: ",bolsillo_dragged.item.nombre)

#maneja la actualizacion de la planta con tiempo
"""func _proceso_planta():
	
	contador_tiempo.text=bolsillo_dragged.item.tiempo
	#TIEMPO DE COSECHA
	while contador >0: #mientraS NO SE HAYA ACABADO SU TIEMPO DE COSECHA EL CONTADOR DISMINUYE
		contador
"""
