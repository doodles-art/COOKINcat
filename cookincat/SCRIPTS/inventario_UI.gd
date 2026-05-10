extends Control

#uso señales porque sirven para comunicar que ha ocurrido un evento sin tener que saber nada del resto (asi se evitan dependencias inecesarias)
signal opened
signal closed


var isOpen :bool=false

@onready var bolsillos_ui
#@onready var bolsillos_data:Array[Bolsillo]=[] 

func _ready():

	Inventario.connect("inventario_actualizado",Callable(self,"update")) #llamo a la funcion de update si recibo la señal (ha habido un cambio en el codigo de inventario)
	#update()#si no la llamo aqui no veria la ui a no ser que añadiera un item
	_updateUI()

func open():
	visible=true
	isOpen=true
	opened.emit() #mando la señal de que el inventario esta abierto
	
	
func close():
	visible=false
	isOpen=false
	closed.emit() #mando la señal de que el inventario esta abierto
	
func _updateUI():
	bolsillos_ui = $CanvasLayer/Panel/GridContainer.get_children() #para asegurarnos de que se impriman correctamente y no se dupliquen
	var values=Inventario.bolsillos.values()
	
	
	for i in range(bolsillos_ui.size()):
		var bolsillo_ui=bolsillos_ui[i]
		bolsillo_ui._set_bolsillo(values[i])
		
		if i <values.size(): #no ha llegado al maximo de la lista 
			bolsillo_ui._set_bolsillo(values[i])
		else: #llega al max
			bolsillo_ui._set_bolsillo(null)
