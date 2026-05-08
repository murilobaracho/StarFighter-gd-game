extends Area2D

var velocidade = Vector2.ZERO

func _physics_process(delta):
	position += velocidade * delta

	var tela = get_viewport_rect().size
	if position.y < -20 or position.y > tela.y + 20:
		queue_free()

func _ao_colidir_com_corpo(corpo):
	if corpo.is_in_group("inimigos"):
		corpo.receber_dano()
		queue_free()

func _ao_colidir_com_area(area):
	if area.is_in_group("inimigos"):
		area.receber_dano()
		queue_free()
