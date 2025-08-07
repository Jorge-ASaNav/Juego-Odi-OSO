extends Area2D

var pantalla=Vector2()

func mover():
	var pos=Vector2(rand_range(0,pantalla.x),rand_range(0,pantalla.y))
	var animacion=Tween.new()
	var duracion
	if abs(pos.x) > pantalla.x / 2 or abs(pos.y) > pantalla.y /2 :
		duracion=2.0
	else:
		duracion=1.0
		
	animacion.interpolate_property(
		self,"position",position,pos,duracion,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	add_child(animacion)
	animacion.start()
	yield(animacion,"tween_completed")
	animacion.queue_free() 
	pass

func configuracion(pos):
	position=pos
