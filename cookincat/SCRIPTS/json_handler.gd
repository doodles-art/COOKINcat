extends Node

var wallet = {}

func load_json_file(file_path:String)-> Dictionary: 
	#container = var dinero, file = wallet_data.json
	
	var file  = FileAccess.open(file_path,FileAccess.READ) #Abrir file para lectura, si no existe lo crea (open())
	if file == null:
		return {} #Retorna diccionario vacío si no existe
		
	var json = file.get_as_text() #Leer file como text
	var json_obj = JSON.new()     #Crear obj para parsear
	var parse_result = json_obj.parse(json) #Parsear mediante el obj JSON 
	
	if parse_result == OK:   #si lo ha parseado bien
		return json_obj.data #devuelves el resultado tras parsear
	else:
		return {}

func write_json_file(data:Dictionary,file_path:String):
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	if file == null:
		return  # si no se puede abrir
	
	var json_text = JSON.stringify(data, "	")
	file.store_string(json_text)
	file.close()

# json_handler.gd (fragmento)

func sell(item: Item, cantidad: int) -> void:
	# Actualizar inventario y cargar wallet
	Inventario.cargar_inventario()
	wallet = load_json_file("res://JSON_files/wallet_data.json")
	
	# Buscar el item en el inventario del jugador
	var bolsillo_encontrado = null
	for bolsillo in Inventario.bolsillos.values():
		if bolsillo.item.id == item.id:
			bolsillo_encontrado = bolsillo
			break
	
	if bolsillo_encontrado == null:
		print("No tienes ese item en el inventario.")
		return
	
	if bolsillo_encontrado.cantidad >= cantidad:
		var ganancia = item.precio * cantidad
		wallet["money"] += ganancia
		Inventario.restar_item(item.id, cantidad)   # método público que resta del inventario
		write_json_file(wallet, "res://JSON_files/wallet_data.json")
		print("Vendido %d %s. Ganancia: %d. Dinero actual: %d" % [cantidad, item.nombre, ganancia, wallet["money"]])
	else:
		print("No tienes suficientes %s. Solo tienes %d." % [item.nombre, bolsillo_encontrado.cantidad])

func buy(item: Item, cantidad: int) -> void:
	Inventario.cargar_inventario()
	wallet = load_json_file("res://JSON_files/wallet_data.json")
	
	var coste = item.precio * cantidad
	
	if coste <= wallet["money"]:
		wallet["money"] -= coste
		Inventario.sumar_item(item.id, cantidad)   # método público que suma al inventario
		write_json_file(wallet, "res://JSON_files/wallet_data.json")
		print("Comprado %d %s. Coste: %d. Dinero restante: %d" % [cantidad, item.nombre, coste, wallet["money"]])
	else:
		print("Dinero insuficiente. Necesitas %d, tienes %d." % [coste, wallet["money"]])

#Modo de empleo:
#Primero se carga lo que haya en el archivo .json en la variable:
# wallet = load_json_file(ruta.json)
#Haces alguna modificación en la variable (wallet) con sell()/comprar()
#La info de wallet se guarda en el json: write_json_file(). 
