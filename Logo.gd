extends Node


func _ready():
	Musica.general(true)
	
func _on_TextureButton_pressed():
	get_tree().change_scene("res://Principal.tscn")
	pass # Replace with function body.
