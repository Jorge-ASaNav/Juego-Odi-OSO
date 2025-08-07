extends CanvasLayer

signal nuevo_juego

func _ready():
	$Control/BotonInicio.grab_focus()

func actualizaScore(valor):
	$Control/HBoxContainer/Score.text=str(valor)

func actualizarTiempo(valor):
	$Control/HBoxContainer/Tiempo.text=str(valor)

func muestraMensaje(texto):
	$Control/Mensajes.text=texto
	$Control/Mensajes.show()
	$TiempoMensaje.start()

func _on_TiempoMensaje_timeout():
	$Control/Mensajes.hide()
	pass # Replace with function body.


func _on_BotonInicio_pressed():
	$Control/BotonInicio.hide()
	$Control/Mensajes.hide()
	$Control/Tutorial.hide()
	emit_signal("nuevo_juego")
	
func gameOver():
	muestraMensaje("Game Over")
	#COngela el juego al perder y ejecuta el siguiente codigo con todo congelado
	yield($TiempoMensaje,"timeout")
	$Control/BotonInicio.show()
	$Control/BotonInicio.grab_focus()
	$Control/Mensajes.text="Odi-Oso"
	$Control/Mensajes.show()
	$Control/Tutorial.show()
	pass # Replace with function body.


func _on_Tutorial_pressed():
	get_tree().change_scene("res://Tutorial.tscn")
	pass # Replace with function body.
