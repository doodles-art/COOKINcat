extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MenuControl.visible=false #Hace que este control pase de ser visible a no visible


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Cuando pulsa ESC aparece el Menu de Pausa
func _input(event):
	if event.is_action_pressed("Menu_Pausa"): #si al detectar input detecta el de MenuPausa (ESC) va a la funcion de abajo
		$MenuControl.visible=true #El menu se hace visible
		
		
#CONTINUE
func _on_continue_pressed() -> void:
	$MenuControl.visible=false #Hace que este control pase de ser visible a no visible
	

#SAVE
func _on_save_pressed() -> void:
	pass # Replace with function body.

#EXIT
func _on_exit_pressed() -> void:
	get_tree().quit() #Lee las escenas con tree y sale de todas
