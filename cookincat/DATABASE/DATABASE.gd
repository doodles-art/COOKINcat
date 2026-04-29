extends Control

var database : SQLite # Definimos que database es una variable de tipo SQLLITE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	database=SQLite.new() #Creamos la base de datos en esta variable
	
	database.path="res://DATABASE/DATABASE.gd" #le indicamos donde se encuentra (user-> para que lo lea del disco y detecte mejor los cambios
	database.open_db() #Para asi abrirla y poder conocer su contenido
	
	#comprobacion (con consultas)
	database.query("SELECT name FROM sqlite_master WHERE type='table';")
	print("Tablas encontradas:", database.query_result)
	
	database.query("SELECT Nombre FROM CULTIVO")
	print(database.query_result)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
