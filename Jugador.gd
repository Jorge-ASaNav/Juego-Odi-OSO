extends Area2D
export (int) var velocidad
var movimiento=Vector2()
var limiteMundo

#Señales
signal recoge
signal golpe

# Called when the node enters the scene tree for the first time.
func _ready():
	limiteMundo=get_viewport_rect().size
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movimiento=Vector2()
	if Input.is_action_pressed("d"):
		movimiento.x+=1
		print("derecha")
	elif Input.is_action_pressed("a"):
		movimiento.x-=1
		print("Izquierda")
	elif Input.is_action_pressed("s"):
		movimiento.y+=1
		print("Abajo")
	elif Input.is_action_pressed("w"):
		movimiento.y-=1
		$AnimatedSprite.animation="Subir"
		print("Arriba")
	else:
		$AnimatedSprite.animation="Inactivo"
		print("Inactivo")
	if movimiento.length()>0:
		movimiento+=movimiento.normalized()*velocidad
	position+=movimiento*delta
	position.x=clamp(position.x,0,limiteMundo.x)
	position.y=clamp(position.y,0,limiteMundo.y)
	
	if movimiento.x !=0:
		$AnimatedSprite.animation="Correr"
		$AnimatedSprite.flip_h=movimiento.x>0
	if movimiento.y !=0:
		$AnimatedSprite.animation="Subir"
		$AnimatedSprite.flip_h=movimiento.x>0
func morir():
	$AnimatedSprite.animation="Dolor"
	set_process(false)

func _on_Jugador_area_entered(areas):
	if areas.is_in_group("manzana"):
		areas.recoge()
		emit_signal("recoge","manzana")
	if areas.is_in_group("Lobo"):
		emit_signal("golpe")
		morir()
	if areas.is_in_group("poder"):
		areas.recoge()
		emit_signal("recoge","poder")
	pass # Replace with function body.
