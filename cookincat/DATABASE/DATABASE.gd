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
	cargar_TexturaItems() #Carga las tcturas de cada item en el Diccionario_Item y en la tabla de SQL (En godot y SQL)
	
	

func cargar_DatosItems():
	
	#Quiero leer la informacion de la tabla ITEMS y CULTIVOS (que son como unos "diccionarios" de la info de cada objeto del juego)
	database.query("SELECT * FROM ITEMS AS i JOIN CULTIVOS AS c ON i.ID_CULTIVO = c.ID")

	#Creo un resource de Godot con los datos de cada fila de la base de datos entre la tabla ITEMS y CULTIVOS 
	for row in database.query_result:
		var item_dato:=Item.new()
		item_dato.id=row["ID_Item"]
		item_dato.id_cultivo=row["ID_Cultivo"]
		item_dato.nombre=row["Nombre"]
		item_dato.icon_texture_path=row["Icono"]
		item_dato.tipo=row["Tipo"]
		item_dato.precio=row["Precio"]
		item_dato.tiempo=row["Tiempo"]
		
		
		Diccionario_Item[item_dato.id]=item_dato #lo añado con esta info al array/diccionario (De sql a godot)
		
		
		
func cargar_TexturaItems():
	
	#recorremos todo el diccionario de items que creamos antes
	for i in Diccionario_Item:
		print(i,Diccionario_Item[i].nombre,Diccionario_Item[i].tipo)
		
		#si no hemos rellenado todavia la textura y esta "vacio" (sin ninguna textura)
		if Diccionario_Item[i].icon_texture_path=="None":
			var path:=""
			
			if Diccionario_Item[i].tipo=="Semilla": #el objeto es de tipo Semilla
				path="res://Sprites/Items/%s_semilla.png"%Diccionario_Item[i].nombre #sustituimos en la ruta el nombre por el nombre del item
				#(para no tener que pasarle la ruta de la textura uno por uno (tardas demasiado :( )
			
			
			if Diccionario_Item[i].tipo=="Cultivo": #El objeto es de tipo Cultivo
				path="res://Sprites/Items/%s_cultivo.png"%Diccionario_Item[i].nombre#sustituimos en la ruta el nombre por el nombre del item
				
				
			#guardamos en el resource (en godot)
			Diccionario_Item[i].icon_texture_path=path #la ruta basada en el tipo y el nombre del item
			
			#guardamos en SQL
			var sql_query="UPDATE ITEMS SET Icono='%s' WHERE ID_Item=%s" % [path,i]
			database.query(sql_query)
