extends Control

class_name InventoryManager

var db:SQLite
var bolsillos: Dictionary={} #como un array pero la busqueda de cada Item se hace de manera mas rapida y simple

func _ready() -> void:
	db=SQLite.new() #Creamos la base de datos en esta variable
	
	db.path="res://DATABASE/CookinCatDATABASE"#le paso la ruta de la Database en el proyecto de Godot
	db.open_db() #Para asi abrirla y poder conocer su contenido (Por si hay algun Item)
	_cargar_inventario()
	
	
func _cargar_inventario():
	bolsillos.clear() #para no repetir filas las elimino y me aseguro de que no pase esto 
	
	db.query("Select * FROM INVENTARIO")
	
	#PASO LA INFORMACION DE CADA FILA DE LA TABLA EN SQLLITE A EL ARRAY/DICCIONARIO EN GODOT (PARA ACCEDER A EL SIN NECESIDAD DE HACER QUERY toDO EL RATO)
	for row in db.query_result:
		var bolsillo:=Bolsillo.new() #creo un "objeto" de tipo Bolsillo
		bolsillo.id_bolsillo=row["ID_Bolsillo"]
		bolsillo.id_item=row["ID_Item"]
		bolsillo.cantidad=row["Cantidad"]
		
		bolsillos[bolsillo.id_bolsillo]=bolsillo #lo añado con esta info al array/diccionario
		
		
	
func _sumarItem(id_objeto:int, cantidad:int):
	#busco si ya hay un objeto del mismo tipo ya en el inventario
	for bolsillo in bolsillos.values():
		
		if(bolsillo.id_bolsillo==id_objeto): #lo encuentra
			bolsillo.cantidad+=cantidad
			db.query("UPDATE INVENTARIO SET Cantidad=? WHERE ID_Bolsillo=?
			[bolsillo.cantidad,bolsillo.id_bolsillo]")
			return #sale de la funcion y acaba
			
		#no lo encuentra
		var nuevo_bolsillo:=Bolsillo.new()
		nuevo_bolsillo.id_bolsillo=bolsillos.size()+1 #aumento el tamaño de la lista
		nuevo_bolsillo.id_item=id_objeto
		nuevo_bolsillo.cantidad=cantidad
		
		bolsillos[nuevo_bolsillo.id_bolsillo]=nuevo_bolsillo #añado este bolsillo con esta info al inventario
		db.query("INSERT INTO INVENTARIO (ID_Bolsillo,ID_Item,Cantidad) VALUES ([nuevo_bolsillo.id_bolsillo,id_objeto,cantidad])")
		
	
	
	
func _restarItem(id_objeto:int,cantidad:int)->void:
	#busco si hay un objeto del mismo tipo en el inventario
	for bolsillo in bolsillos.values():
		
		if(bolsillo.id_bolsillo==id_objeto): #lo encuentra
			
			if bolsillo.cantidad>0:
				while bolsillo.cantidad>0 && cantidad>=0: 
					bolsillo.cantidad-1
					cantidad-1
					db.query("UPDATE INVENTARIO SET Cantidad=? WHERE ID_Bolsillo=?
					[bolsillo.cantidad,bolsillo.id_bolsillo]")
					
			if bolsillo.cantidad<=0:
				db.query("DELETE FROM INVENTARIO WHERE ID_Bolsillo=?,[id_bolsillo,bolsillos.erase(id_bolsillo)]")	
				
			return
		
