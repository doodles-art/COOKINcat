extends Area2D

#este area sirve para guiar al jugador hacia donde tiene que plantar en el huerto

class_name SlotHuerto_UI
@export var slot_huerto: SlotHuerto #resource con info del huerto
@onready var icono:Panel=$Panel

var is_dragging :=false
var bolsillo_ui_ref: Bolsillo_UI = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
	
func _plantar():
	var bolsillo_ui_ref=BolsilloUi.current_drag_bolsillo
	#slot_huerto.item =bolsillo_ui_ref.item
	print("Item plantado: ",bolsillo_ui_ref)




func _on_input_event(viewport: Viewport, event: InputEvent, shape_idx: int):
	if event is InputEventMouseButton and event.pressed:
		print("CLICK DETECTADO EN SLOT")  # Esto debe aparecer al hacer click
		if BolsilloUi.is_dragging:
			_plantar()


func _on_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	print("FUERA")

func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	print ("DENTRO",area)
	_plantar()
