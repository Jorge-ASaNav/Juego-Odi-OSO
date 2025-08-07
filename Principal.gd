extends Node

export (PackedScene) var Manzana
export (PackedScene) var Poder
export (int) var tiempoJuego

var nivel
var score
var tiempoRestante
var pantalla
var jugando=false

func _ready():
	randomize()
	pantalla=get_viewport().get_visible_rect().size
	$Jugador.limiteMundo=pantalla
	$Jugador.hide()
	$Lobo.pantalla=pantalla
	$Lobo.hide()
	
func nuevoJuego():
	nivel=1
	score=0
	tiempoRestante=tiempoJuego
	jugando=true
	$Jugador.position=$InicioJugador.position
	$Jugador.set_process(true)
	$Jugador.show()
	$Lobo.show()
	$Lobo.configuracion($InicioLobo.position)
	$TimerJuego.start()
	invoca_manzana()
	$HUD.actualizaScore(score)
	$HUD.actualizarTiempo(tiempoRestante)
	Musica.general(false)
	Musica.musicaFondo(true)
	
func invoca_manzana():
	for i in 3 + nivel:
		var manza=Manzana.instance()
		$ContenedorManzana.add_child(manza)
		manza.pantalla=pantalla
		manza.position=Vector2(rand_range(0,pantalla.x),rand_range(0,pantalla.x))
	pass
	
func _process(delta):
	if jugando and $ContenedorManzana.get_child_count()==0:
		nivel+=1
		Musica.play("level_up",15)
		tiempoRestante+=6
		$Lobo.mover()
		invoca_manzana()
		invocaPoder()

func _on_TimerJuego_timeout():
	tiempoRestante-=1
	$HUD.actualizarTiempo(tiempoRestante)
	if tiempoRestante < 0:
		gameOver()
		tiempoRestante=0

func gameOver():
	Musica.play("die",15)
	Musica.musicaFondo(false)
	Musica.general(true)
	jugando=false
	$TimerJuego.stop()
	for manzana in $ContenedorManzana.get_children():
		manzana.queue_free()
	$HUD.gameOver()
	$Jugador.morir()
	pass


func _on_Jugador_golpe():
	gameOver()
	pass # Replace with function body.


func _on_Jugador_recoge(tipo):
	match tipo:
		"manzana":
			score+=1
			$HUD.actualizaScore(score)
			Musica.play("pickup_apple",15)
		"poder":
			score+=5
			tiempoRestante+=5
			$HUD.actualizaScore(score)
			$HUD.actualizarTiempo(tiempoRestante)
			Musica.play("powerup",15)
	pass # Replace with function body.


func _on_HUD_nuevo_juego():
	nuevoJuego()
	pass # Replace with function body.

func invocaPoder():
	$PoderesTimer.wait_time=rand_range(1,8)
	$PoderesTimer.start()
	pass

func _on_PoderesTimer_timeout():
	var p=Poder.instance()
	add_child(p)
	p.pantalla=pantalla
	p.position=Vector2(rand_range(0,pantalla.x),rand_range(0,pantalla.x))
	pass # Replace with function body.
