extends Control

class_name Inventory

signal inventario_actualizado


var db:SQLite

#lista de los bolsillos del inventario del jugador
var bolsillos: Dictionary={} #como un array pero la busqueda de cada Item se hace de manera mas rapida y simple

func _ready() -> void:
	db=SQLite.new() #Creamos la base de datos en esta variable
	
	db.path="res://DATABASE/CookinCatDATABASE"#le paso la ruta de la Database en el proyecto de Godot
	db.open_db() #Para asi abrirla y poder conocer su contenido (Por si hay algun Item)
	_cargar_inventario()
	print("BD usada: ", db.path)
#cargo el inventario guardado del jugador nada mas comenzar el juego
func _cargar_inventario():
	bolsillos.clear() #para no repetir filas las elimino y me aseguro de que no pase esto 
	#SOLO QUIERO DE CULTIVOS E ITEMS LOS DATOS QUE ME INTERESEN PARA LOS OBJETOS ACTUALES DEL INVENTARIO
	db.query("Select * FROM INVENTARIO AS INV LEFT JOIN ITEMS AS ITM ON INV.ID_Item=ITM.ID_Item LEFT JOIN CULTIVOS AS CLT ON ITM.ID_Cultivo=CLT.ID")
	print(db.query_result)
	#PASO LA INFORMACION DE CADA FILA DE LA TABLA EN SQLLITE A EL ARRAY/DICCIONARIO EN GODOT (PARA ACCEDER A EL SIN NECESIDAD DE HACER QUERY toDO EL RATO)
	for row in db.query_result:
		var bolsillo:=Bolsillo.new() #creo un "objeto" de tipo Bolsillo
		#son como una referencia al item real en el "diccionario" de items
		bolsillo.id_bolsillo=row["ID_Bolsillo"]
		bolsillo.item = Database.Diccionario_Item[row["ID_Item"]] #item incluye icono,tipo,precio 
		bolsillo.cantidad=row["Cantidad"]
		
		#enlazamos el resource item real
		bolsillo.item=Database.Diccionario_Item[bolsillo.id_bolsillo]
		bolsillos[bolsillo.id_bolsillo]=bolsillo #lo añado con esta info al inventario (De sql a godot)
		emit_signal("inventario_actualizado")#envio unaq señal de que he actualizado el inventario
		
		
	
func _sumarItem(id_objeto:int, cantidad:int):
	
	if bolsillos.is_empty()==true: #si no hay ningun elemento en el diccionario (inventqrio vacio)
		_insertarBolsillo(id_objeto,cantidad) #creo un nuevo bolsillo con este
	
	if bolsillos.is_empty()==false: #hay al menos un elemento en el diccionario (ahora tengo que ver si el tipo de elemento que quiero insertar se encuentra ya en el inventario)

		#busco si ya hay un objeto del mismo tipo ya en el inventario
		for bolsillo in bolsillos.values():
			
			if(bolsillo.item.id==id_objeto): #lo encuentra
				bolsillo.cantidad+=cantidad
				db.query( "UPDATE INVENTARIO SET Cantidad=%d WHERE ID_Bolsillo=%d" % [bolsillo.cantidad,bolsillo.id_bolsillo])


				return #sale de la funcion y acaba
			
			else:#no lo encuentra (entonces tenemos que crear otro bolsillo con este "nuevo" tipo de dato
				_insertarBolsillo(id_objeto,cantidad)

	print("añadio")
	print(id_objeto,cantidad)#compuebo
	emit_signal("inventario_actualizado")#envio unaq señal de que he actualizado el inventario
	

func _restarItem(id_objeto:int,cantidad:int)->void:
	emit_signal("inventario_actualizado")#envio unaq señal de que he actualizado el inventario
	#busco si hay un objeto del mismo tipo en el inventario
	for bolsillo in bolsillos.values():
		
		if(bolsillo.id_bolsillo==id_objeto): #lo encuentra
			
			if bolsillo.cantidad>0:
				while bolsillo.cantidad>0 && cantidad>=0: 
					bolsillo.cantidad=bolsillo.cantidad-1
					cantidad=cantidad-1
					db.query( "UPDATE INVENTARIO SET Cantidad=%d WHERE ID_Bolsillo=%d" % [bolsillo.cantidad,bolsillo.id_bolsillo])
					
			if bolsillo.cantidad<=0:
				db.query("DELETE FROM INVENTARIO WHERE ID_Bolsillo=%d"%[bolsillo.id_bolsillo,bolsillos.erase(bolsillo.id_bolsillo)])	
				
			return

#funcion que uso para insertar un nuevo bolsillo al inventario (lo uso para cuando no haya ningun bolsillo en la tabla o para cuando no haya ningun item de ese tipo todavia en el inventario)
func _insertarBolsillo(id_objeto:int,cantidad:int)->void:
	var nuevo_bolsillo:=Bolsillo.new()
	nuevo_bolsillo.id_bolsillo=bolsillos.size()+1 #aumento el tamaño de la lista
	nuevo_bolsillo.item = Database.Diccionario_Item[id_objeto]
	nuevo_bolsillo.cantidad=cantidad
		
	bolsillos[nuevo_bolsillo.id_bolsillo]=nuevo_bolsillo #añado este bolsillo con esta info al inventario
	db.query("INSERT INTO INVENTARIO (ID_Bolsillo, ID_Item, Cantidad) VALUES (%d, %d, %d)" % [nuevo_bolsillo.id_bolsillo,id_objeto,cantidad])
	print(db.query_result)#comprueba
