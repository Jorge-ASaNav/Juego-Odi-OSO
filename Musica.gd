extends Node

func play(nombre,volumen):
	var reproductor=AudioStreamPlayer.new()	
	reproductor.volume_db=-volumen
	reproductor.stream=$ResourcePreloader.get_resource(nombre)
	reproductor.connect("finished",reproductor,"queue_free")
	reproductor.play()
	add_child(reproductor)
	
func musicaFondo(valor):
	if valor:
		$AudioStreamPlayer.play()
	else:
		$AudioStreamPlayer.stop()

func general(valor):
	if valor:
		$General.play()
	else:
		$General.stop()
