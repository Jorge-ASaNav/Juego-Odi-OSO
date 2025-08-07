extends Area2D

var pantalla=Vector2()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func recoge():
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Manzana_area_entered(area):
	if area.is_in_group("Lobo"):
		position=Vector2(rand_range(0,pantalla.x),rand_range(0,pantalla.y))
	pass # Replace with function body.
