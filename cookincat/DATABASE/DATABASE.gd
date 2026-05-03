extends Control

var database : SQLite # Definimos que database es una variable de tipo SQLLITE
var Diccionario_Item: Dictionary={} #Diccionario de cada Item con sus datps (contiene un resource de tipo Item)
#lo cargo en godot para no tener que acceder todo el rato a sql y que l proceso de busqueda de datos sea mas rapida

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	database=SQLite.new() #Creamos la base de datos en esta variable
	
	database.path="res://DATABASE/CookinCatDATABASE"#le paso la ruta de la Database en el proyecto de Godot
	database.open_db() #Para asi abrirla y poder conocer su contenido

	cargar_DatosItems()#Carga el diccionario con los datos de cada item cada vez quje incie el juego



func cargar_DatosItems():
	
	#Quiero leer la informacion de la tabla ITEMS y CULTIVOS (que son como unos "diccionarios" de la info de cada objeto del juego)
	database.query("SELECT * FROM ITEMS AS i JOIN CULTIVOS AS c ON i.ID_CULTIVO = c.ID")

	#CARGO LOS DATOS QUE SE ENCONTRABAN EN LA BASE DE DATOS AL INICIAR EL JUEGO (INFO DE CADA ITEM COMO UN DICCIONARIO PARA CONSULTARLO EN EL JUEGO)
	for row in database.query_result:
		var item_dato:=Item.new()
		item_dato.id=row["ID"]
		item_dato.id_cultivo=row["ID_Cultivo"]
		item_dato.nombre=row["Nombre"]
		item_dato.tipo=row["Tipo"]
		item_dato.precio=row["Precio"]
		item_dato.tiempo=row["Tiempo"]
		
		print(item_dato.id,item_dato.nombre,item_dato.tipo)#comprobacion
		Diccionario_Item[item_dato.id]=item_dato #lo añado con esta info al array/diccionario (De sql a godot)
		
