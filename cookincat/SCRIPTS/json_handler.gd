extends Node

#var file_path = "res://JSON_files/wallet.json"
var wallet = {}

func load_json_file(file_path:String)-> Dictionary: 
	#container=var dinero, file=wallet.json
	
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

func vender_cultivo(cultivo:Item,cantidad:int):
	#comprobar que venda sólo lo que tiene
	var pv = cultivo["precio"]   #precio de venta
	var ganancia = pv * cantidad #calcular ganancia
	wallet["money"]+= ganancia   #añadir ganancias
	#restar cantidad del item en inventario
	
func comprar_semillas(cultivo:Item,cantidad:int):
	var pv = cultivo["precio"]   #precio de venta
	var coste = pv * cantidad #calcular coste
	wallet["money"]-= coste   #restar coste
	#añadir cantidad del item al inventario

#Por ejemplo:
#Primero se carga lo que haya en el archivo .json en la variable:
#var wallet_data = load_json_file(ruta.json)
#Haces alguna modificación en la variable (wallet_data) con vender()/comprar()
#La info de wallet se guarda en el json: write_json_file(). 
