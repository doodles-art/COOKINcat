extends Control

#uso señales porque sirven para comunicar que ha ocurrido un evento sin tener que saber nada del resto (asi se evitan dependencias inecesarias)
signal opened
signal closed

const SCENE_BOLSILLOUI = preload("res://UI/bolsillo.tscn") #cargo la escena para crear hijos/crear los bolsillos desde el codigo


var isOpen :bool=false

@onready var bolsillos_ui:Array #esta clase contiene fondo, icono y cantidad
#@onready var bolsillos_data:Array[Bolsillo]=[] 

func _ready():
	print("Bolsillos en SQL al iniciar UI: ", Inventario.bolsillos.size())

	_cargarInventarioUI()
	#se suma un nuevo item (añadimos un bolsillo)
	Inventario.connect("inventario_actualizado_suma",Callable(self,"_sumarBolsilloUI")) #llamo a la funcion de update si recibo la señal (ha habido un cambio en el codigo de inventario)
	#se resta un nuevo item (restamos un bolsillo
	Inventario.connect("inventario_actualizado_suma",Callable(self,"_restarBolsilloUI")) #llamo a la funcion de update si recibo la señal (ha habido un cambio en el codigo de inventario
	#update()#si no la llamo aqui no veria la ui a no ser que añadiera un item
	

func open():
	visible=true
	isOpen=true
	opened.emit() #mando la señal de que el inventario esta abierto
	
	
func close():
	visible=false
	isOpen=false
	closed.emit() #mando la señal de que el inventario esta abierto
	
"""func _updateUI():
	bolsillos_ui = $CanvasLayer/Panel/GridContainer.get_children() #para asegurarnos de que se impriman correctamente y no se dupliquen
	var values=Inventario.bolsillos.values()
	
	for i in range(bolsillos_ui.size()):
		var bolsillo_ui=bolsillos_ui[i]
		bolsillo_ui._set_bolsillo(bolsillos_ui[i])
		
		if i <bolsillos_ui.size(): #no ha llegado al maximo de la lista 
			bolsillo_ui._set_bolsillo(bolsillos_ui[i])
		else: #llega al max
			bolsillo_ui._set_bolsillo(null)
"""

func _cargarInventarioUI():#RECORRRO TODOS LOS BOLSILLOS(INVENTARIO) PARA CARGARLO EN LA UI
	bolsillos_ui.clear() #Lo limpio para que no queden rastros del inicio anterior del juego
	print("Cargo inventario UI")
	
	#si no hay ningun item en la lista de bolsillos no carga nada
	for bolsillo in Inventario.bolsillos.values(): #lista de bolsillos del inventario(junto con la info de los items que contiene cada bolsillo)
		print("entro en el bucle")
		var bolsillo_ui = SCENE_BOLSILLOUI.instantiate() #creo un NUEVO bolsillo en escena
		$CanvasLayer/Panel/GridContainer.add_child(bolsillo_ui)

		bolsillo_ui._set_bolsillo(bolsillo)#funcion de bolsilloUi que lee el bolsillo que le paso y coge su textura y cantidad
		print(bolsillo.id_bolsillo)
		

func _sumarBolsilloUI():
	
	$CanvasLayer/Panel/GridContainer.add_child(bolsillo_ui)
	var bolsillo_ui = SCENE_BOLSILLOUI.instantiate() #creo un NUEVO bolsillo en escena
	$CanvasLayer/Panel/GridContainer.add_child(bolsillo_ui)

	bolsillo_ui._set_bolsillo(bolsillo)
	

func _restarBolsilloUI():
