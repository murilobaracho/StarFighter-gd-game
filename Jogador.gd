extends KinematicBody2D

signal morreu

const VELOCIDADE = 300
const VELOCIDADE_TIRO = 600
const VIDA_MAXIMA = 3

var vida = VIDA_MAXIMA
var pode_atirar = true
var recarga = 0.25
var velocidade = Vector2.ZERO

onready var temporizador_recarga = $ShootTimer
onready var animacao = $AnimatedSprite
onready var temporizador_invencivel = $InvincibilityTimer
onready var hud = get_node("/root/Main/HUD")

func _ready():
	temporizador_recarga.wait_time = recarga

func _physics_process(delta):
	ler_entrada()
	velocidade = move_and_slide(velocidade)
	limitar_na_tela()

func ler_entrada():
	velocidade = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		velocidade.x = VELOCIDADE
	if Input.is_action_pressed("ui_left"):
		velocidade.x = -VELOCIDADE
	if Input.is_action_pressed("ui_down"):
		velocidade.y = VELOCIDADE
	if Input.is_action_pressed("ui_up"):
		velocidade.y = -VELOCIDADE

	if Input.is_action_pressed("ui_accept") and pode_atirar:
		atirar()

func limitar_na_tela():
	var tela = get_viewport_rect().size
	position.x = clamp(position.x, 0, tela.x)
	position.y = clamp(position.y, 0, tela.y)

func atirar():
	pode_atirar = false
	temporizador_recarga.start()

	var cena_bala = load("res://BalaJogador.tscn")
	var bala = cena_bala.instance()
	bala.position = global_position + Vector2(0, -30)
	bala.velocidade = Vector2(0, -VELOCIDADE_TIRO)
	get_parent().add_child(bala)

func receber_dano():
	if temporizador_invencivel.is_stopped():
		vida -= 1
		hud.atualizar_vida(vida)
		temporizador_invencivel.start()
		animacao.modulate = Color(1, 0.3, 0.3)

		if vida <= 0:
			emit_signal("morreu")
			queue_free()

func _ao_recarga_terminar():
	pode_atirar = true

func _ao_invencibilidade_terminar():
	animacao.modulate = Color(1, 1, 1)
