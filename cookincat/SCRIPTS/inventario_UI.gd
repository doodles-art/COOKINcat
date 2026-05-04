extends Control

#uso señales porque sirven para comunicar que ha ocurrido un evento sin tener que saber nada del resto (asi se evitan dependencias inecesarias)
signal opened
signal closed

var isOpen :bool=false

@onready var bolsillos:Array= $CanvasLayer/Panel/GridContainer.get_children() #de esta manera cojo los bolsillos del inventario que contiene el GridContainer

func _ready():
	update()
	
func update():
	var inv=Inventario.bolsillos.values() #Inventario ->Autoload (puedes acceder al scrip desde cualquier script)
	for i in range(min(inv.size(),bolsillos.size())):
		var bolsillo_nodo=bolsillos[i]
		var item=inv[i]
		
		bolsillo_nodo.set_item(item)
	

func open():
	visible=true
	isOpen=true
	opened.emit() #mando la señal de que el inventario esta abierto
	
	
func close():
	visible=false
	isOpen=false
	closed.emit() #mando la señal de que el inventario esta abierto
