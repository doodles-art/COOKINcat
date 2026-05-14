extends Node

#var file_path = "res://JSON_files/wallet.json"

func load_json_file(file_path:String)-> Dictionary: 
	#container=var dinero, file=wallet.json
	
	var file  = FileAccess.open(file_path,FileAccess.READ) #Abrir file para lectura, si no existe lo crea (open())
	if file == null:
		return {} #Retorna diccionario vacío si no existe
		
	var json = file.get_as_text() #Leer file como text
	var json_obj = JSON.new() #Crear obj para parsear
	var parse_result = json_obj.parse(json) #Parsear mediante el obj JSON 
	
	if parse_result == OK: #si lo ha parseado bien
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
