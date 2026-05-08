extends KinematicBody2D

signal morreu

const VELOCIDADE = 120
const INTERVALO_TIRO = 2.5
const VELOCIDADE_TIRO = 250
const PONTOS = 100

var vida = 2
var direcao = Vector2.DOWN
var temporizador_tiro = 0.0
var temporizador_movimento = 0.0
var sentido_lateral = 1

func _physics_process(delta):
	move_and_slide(direcao * VELOCIDADE + Vector2(sentido_lateral * 60, 0))

	temporizador_tiro += delta
	if temporizador_tiro >= INTERVALO_TIRO:
		temporizador_tiro = 0.0
		atirar()

	temporizador_movimento += delta
	if temporizador_movimento >= 1.2:
		temporizador_movimento = 0.0
		sentido_lateral *= -1

	if position.y > get_viewport_rect().size.y + 50:
		queue_free()

func atirar():
	var cena_bala = load("res://BalaInimigo.tscn")
	var bala = cena_bala.instance()
	bala.position = global_position + Vector2(0, 30)
	bala.velocidade = Vector2(0, VELOCIDADE_TIRO)
	get_parent().add_child(bala)

func receber_dano():
	vida -= 1
	modulate = Color(1, 0.5, 0)

	yield(get_tree().create_timer(0.1), "timeout")
	modulate = Color(1, 1, 1)

	if vida <= 0:
		emit_signal("morreu")
		criar_explosao()
		queue_free()

func criar_explosao():
	var explosao = Sprite.new()
	explosao.position = global_position
	get_parent().add_child(explosao)
	yield(get_tree().create_timer(0.4), "timeout")
	explosao.queue_free()
