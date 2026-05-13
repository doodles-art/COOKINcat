extends Control

@export var ID_Huerto:int
@export var Num_slots:int

@onready var slotsHuerto:Array
var datab : SQLite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	datab.path="res://DATABASE/CookinCatDATABASE.db"#le paso la ruta de la Database en el proyecto de Godot (Ya que res:// es solo lectura en tiempo de ejecución. por lo que si intento cambiar algo en sql se bloquea)
	datab.open_db() #Para asi abrirla y poder conocer su contenido (Por si hay algun Item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _cargarHuerto():
	slotsHuerto.clear() #para no repetir filas las elimino y me aseguro de que no pase esto 
	
	#cojo la tabla HUERTO junto con SLOTS, CULTIVOS E ITEMS para tener la info de lo que contien cada slot
	datab.query("Select * FROM HUERTO AS HRT LEFT JOIN SLOTS AS SLT ON HRT.ID=SLT.ID_Huerto LEFT JOIN CULTIVOS AS CLT ON SLT.ID_Cultivo=CLT.ID LEFT JOIN ITEM AS ITM ON CLT.ID=ITM.ID_Cultivo")
	
	#PASO LA INFORMACION DE CADA FILA DE LA TABLA EN SQLLITE A EL ARRAY/DICCIONARIO EN GODOT (PARA ACCEDER A EL SIN NECESIDAD DE HACER QUERY toDO EL RATO)
	
	for row in datab.query_result:
		var slot:=SlotHuerto.new() #creo un "objeto" de tipo slot huerto
		#son como una referencia al item real en el "diccionario" de items
		slot.id_slot=row["ID_Slot"]
		slot.item = Database.Diccionario_Item[row["ID_Item"]] #item incluye icono,tipo,precio 
		slot.cantidad=row["Cantidad"]
		
		
		slotsHuerto[slot.id_slot]=slot #lo añado con esta info al inventario (De sql a godot)
		print (slot)
		
		
func _sumarSlot():
	
	
func _restarSlot():
	
