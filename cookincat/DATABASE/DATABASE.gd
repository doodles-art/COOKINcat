extends Control

var database : SQLite # Definimos que database es una variable de tipo SQLLITE
var InfoItem: Array[Item] =[] #Array de cada slot (contiene un resource de tipo Item)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	database=SQLite.new() #Creamos la base de datos en esta variable
	
	database.path="res://DATABASE/CookinCatDATABASE"#le paso la ruta de la Database en el proyecto de Godot
	database.open_db() #Para asi abrirla y poder conocer su contenido

	#cargar_DatosItems()



func cargar_DatosItems():
	
	#Quiero leer la informacion de la tabla ITEMS y CULTIVOS (que son como unos "diccionarios" de la info de cada objeto del juego)
	database.query("SELECT * FROM ITEMS AS i JOIN CULTIVOS AS c ON i.ID_CULTIVO = c.ID")

"""
	#CARGO LOS DATOS QUE SE ENCONTRABAN EN LA BASE DE DATOS AL INICIAR EL JUEGO
	#Meto items de la clase Item (creada en el Script Item_Dato)
	for row in database.query_result:
		var item:=Item.new()
		item.id=row["ID"]
		item.id_cultivo=row["ID_Cultivo"]
		item.nombre=row["Nombre"]
		item.tipo=row["Tipo"]
		item.precio=row["Precio"]
		item.tiempo=row["Tiempo"]
		
		print(item.id,item.nombre,item.tipo)#comprobacion
		slots.append(item) #con esto el array va creciendo y no necesitamos ajustar desde un inicio su tamaño
"""		
		
		
