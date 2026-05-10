extends Control

#uso señales porque sirven para comunicar que ha ocurrido un evento sin tener que saber nada del resto (asi se evitan dependencias inecesarias)
signal opened
signal closed


var isOpen :bool=false

@onready var bolsillos_ui=$CanvasLayer/Panel/GridContainer.get_children()
#@onready var bolsillos_data:Array[Bolsillo]=[] 

func _ready():
	Inventario.connect("inventario_actualizado",Callable(self,"update")) #llamo a la funcion de update si recibo la señal (ha habido un cambio en el codigo de inventario)
	#update()#si no la llamo aqui no veria la ui a no ser que añadiera un item
	_updateUI()
"""func update():
	for i in range(bolsillos_data.size()):
		var bolsillo_resource=bolsillos_data[i]
		var bolsillo_ui=bolsillos_ui[i]
		bolsillo_ui._update(bolsillo_resource) #cargamos en la funcion _update (script bolsillo_ui) el resource que se encuentra en el array bolsillos_data
		
	"""
func open():
	visible=true
	isOpen=true
	opened.emit() #mando la señal de que el inventario esta abierto
	
	
func close():
	visible=false
	isOpen=false
	closed.emit() #mando la señal de que el inventario esta abierto
	
func _updateUI():
	var values=Inventario.bolsillos.values()
	
	for i in range(values.size()):
		var bolsillo_ui=bolsillos_ui[i]
		bolsillo_ui._set_bolsillo(values[i])
		
		if i <values.size(): #no ha llegado al maximo de la lista 
			bolsillo_ui._set_bolsillo(values[i])
		else: #llega al max
			bolsillo_ui._set_bolsillo(null)
