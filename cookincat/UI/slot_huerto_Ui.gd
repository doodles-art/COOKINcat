extends Area2D

#este area sirve para guiar al jugador hacia donde tiene que plantar en el huerto

class_name SlotHuerto_UI
@export var slot_huerto: SlotHuerto #resource con info del huerto
@onready var icono:Panel=$Panel

var is_dragging :=false
var bolsillo_ui_ref: Bolsillo_UI = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_pickable = true
	# Prueba con otra señal
	input_event.connect(_on_input_event)
	
	 # Conectar mouse_shape_entered en lugar de mouse_entered
	
	
func _on_dragging(bolsillo_ui: Bolsillo_UI) -> void:
	is_dragging = true
	bolsillo_ui_ref = bolsillo_ui
	print("esta arrastrando cuidao")
	
func _on_mouse_shape_enter(shape_idx: int) -> void:
	print("¡MOUSE DETECTADO!")  # Este print debe aparecer
	
	if BolsilloUi.is_dragging:
		print("Drag activo - vamos a plantar")
		_plantar()
	
	
func _plantar():
	if BolsilloUi.current_drag_item:  # Variable pública
		slot_huerto.item = BolsilloUi.current_drag_item
		print("Item plantado: ", slot_huerto.item)




func _on_input_event(viewport: Viewport, event: InputEvent, shape_idx: int):
	if event is InputEventMouseButton and event.pressed:
		print("CLICK DETECTADO EN SLOT")  # Esto debe aparecer al hacer click
		if BolsilloUi.is_dragging:
			_plantar()




func _on_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	print("FUERA")

func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:

	print ("DENTRO",area)
