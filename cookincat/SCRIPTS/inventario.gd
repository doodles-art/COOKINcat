extends Control

class_name Inventory

#signal inventario_actualizado
signal inventario_actualizado_suma (bolsillo) #le paso junto con la señal el bolsillo que sumo
signal inventario_actualizado_resta (bolsillo)
signal cantidad_actualizada
#signal accesoSQL

var db:SQLite

#lista de los bolsillos del inventario del jugador
var bolsillos: Dictionary={} #como un array pero la busqueda de cada Item se hace de manera mas rapida y simple

func _ready() -> void:
	
	db=SQLite.new() #Creamos la base de datos en esta variable
	
	db.path="res://DATABASE/CookinCatDATABASE.db"#le paso la ruta de la Database en el proyecto de Godot (Ya que res:// es solo lectura en tiempo de ejecución. por lo que si intento cambiar algo en sql se bloquea)
	db.open_db() #Para asi abrirla y poder conocer su contenido (Por si hay algun Item)
	_cargar_inventario()
	
#cargo el inventario guardado del jugador nada mas comenzar el juego


func _cargar_inventario():
	bolsillos.clear() #para no repetir filas las elimino y me aseguro de que no pase esto 
	#SOLO QUIERO DE CULTIVOS E ITEMS LOS DATOS QUE ME INTERESEN PARA LOS OBJETOS ACTUALES DEL INVENTARIO
	db.query("Select * FROM INVENTARIO AS INV LEFT JOIN ITEMS AS ITM ON INV.ID_Item=ITM.ID_Item LEFT JOIN CULTIVOS AS CLT ON ITM.ID_Cultivo=CLT.ID")
	
	#PASO LA INFORMACION DE CADA FILA DE LA TABLA EN SQLLITE A EL ARRAY/DICCIONARIO EN GODOT (PARA ACCEDER A EL SIN NECESIDAD DE HACER QUERY toDO EL RATO)
	
	for row in db.query_result:
		var bolsillo:=Bolsillo.new() #creo un "objeto" de tipo Bolsillo
		#son como una referencia al item real en el "diccionario" de items
		bolsillo.id_bolsillo=row["ID_Bolsillo"]
		bolsillo.item = Database.Diccionario_Item[row["ID_Item"]] #item incluye icono,tipo,precio 
		bolsillo.cantidad=row["Cantidad"]
		
		
		bolsillos[bolsillo.id_bolsillo]=bolsillo #lo añado con esta info al inventario (De sql a godot)
		#emit_signal("inventario_actualizado")#envio unaq señal de que he actualizado el inventario
		
		
	
func _sumarItem(id_objeto:int, cantidad:int):
	
	if bolsillos.is_empty()==true: #si no hay ningun elemento en el diccionario (inventqrio vacio)
		_insertarBolsillo(id_objeto,cantidad) #creo un nuevo bolsillo con este
		return
		
	if bolsillos.is_empty()==false: #hay al menos un elemento en el diccionario (ahora tengo que ver si el tipo de elemento que quiero insertar se encuentra ya en el inventario)

		#busco si ya hay un objeto del mismo tipo ya en el inventario
		for bolsillo in bolsillos.values():
			print("Bolsillo:", bolsillo.id_bolsillo, " Item:", bolsillo.item.id, " Busco:", id_objeto)
			
			#hace un bucle llendo bolsillo por bolsillo hasta encontrar concicdenciasd
			if(bolsillo.item.id==id_objeto): #lo encuentra
				bolsillo.cantidad+=cantidad
				db.query("UPDATE INVENTARIO SET Cantidad=%d WHERE ID_Bolsillo=%d" % [bolsillo.cantidad,bolsillo.id_bolsillo])
				return #si lo encuentra sale de la funcion y acaba
			
			 #si no lo encuentra continua despues del bucle
		
		_insertarBolsillo(id_objeto,cantidad)
		return
	

func _restarItem(id_objeto:int, cantidad:int) -> void:
	if bolsillos.is_empty():
		return
	
	for bolsillo in bolsillos.values():
		# Comparación correcta: ID del item
		print("Bolsillo:", bolsillo.id_bolsillo, " Item:", bolsillo.item.id, " Busco:", id_objeto)

		if (bolsillo.item.id == id_objeto):
			
			while bolsillo.cantidad > 0 and cantidad > 0:
				bolsillo.cantidad -= 1
				cantidad -= 1
				db.query("UPDATE INVENTARIO SET Cantidad=%d WHERE ID_Bolsillo=%d" % [bolsillo.cantidad,bolsillo.id_bolsillo])
				  
			# Si queda vacío, borrar de SQL y del diccionario
			if bolsillo.cantidad <= 0:
				
				db.query("DELETE FROM INVENTARIO WHERE ID_Bolsillo=%d" % [bolsillo.id_bolsillo])
				bolsillos.erase(bolsillo.id_bolsillo)#lo quito de la lista de godot
				break
				
			emit_signal("inventario_actualizado_resta")
			print(bolsillos.values())
			return


#funcion que uso para insertar un nuevo bolsillo al inventario (lo uso para cuando no haya ningun bolsillo en la tabla o para cuando no haya ningun item de ese tipo todavia en el inventario)
func _insertarBolsillo(id_objeto:int,cantidad:int)->void:
	var nuevo_bolsillo:=Bolsillo.new()
	
	# Insertamos sin ID_Bolsillo (lo genera SQLite)
	db.query("INSERT INTO INVENTARIO (ID_Item, Cantidad) VALUES (%d, %d)" % [id_objeto, cantidad])
	
	 # Recuperamos el ID generado por SQLite
	nuevo_bolsillo.id_bolsillo = db.last_insert_rowid
	
	 # Cargamos el item real
	nuevo_bolsillo.item = Database.Diccionario_Item[id_objeto]
	nuevo_bolsillo.cantidad = cantidad
	
	bolsillos[nuevo_bolsillo.id_bolsillo]=nuevo_bolsillo #añado este bolsillo con esta info al inventario
	emit_signal("inventario_actualizado_suma",nuevo_bolsillo)#envio unaq señal de que he actualizado el inventario + el bolsillo nuevo
	#en sql aunque borres filas y añadas nunca se reutiliza un id anque ya no exista su fila
