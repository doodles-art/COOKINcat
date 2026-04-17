extends Control

var database : SQLite # Definimos que database es una variable de tipo SQLLITE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	database=SQLite.new() #Creamos la base de datos en esta variable
	database.path="res://CookinCatDATABASE.db" #le indicamos donde se encuentra
	database.open_db() #Para asi abrirla y poder conocer su contenido
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
