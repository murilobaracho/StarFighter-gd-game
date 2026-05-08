extends Node

var pontuacao = 0
var onda = 1
var inimigos_restantes = 0
var temporizador_spawn = 0.0
var intervalo_spawn = 2.0
var jogo_encerrado = false

onready var jogador = $Player
onready var hud = $HUD
onready var pontos_de_spawn = $EnemySpawnPoints

func _ready():
	iniciar_onda(onda)

func _process(delta):
	if jogo_encerrado:
		return

	temporizador_spawn += delta
	if temporizador_spawn >= intervalo_spawn and inimigos_restantes > 0:
		temporizador_spawn = 0.0
		spawnar_inimigo()

func iniciar_onda(numero_da_onda):
	inimigos_restantes = 3 + numero_da_onda * 2
	intervalo_spawn = max(0.8, 2.0 - numero_da_onda * 0.1)
	hud.atualizar_onda(numero_da_onda)

func spawnar_inimigo():
	var cena = load("res://Inimigo.tscn")
	var inimigo = cena.instance()

	var posicoes = pontos_de_spawn.get_children()
	var posicao_aleatoria = posicoes[randi() % posicoes.size()]
	inimigo.position = posicao_aleatoria.position

	inimigo.connect("morreu", self, "_ao_inimigo_morrer")
	add_child(inimigo)

func adicionar_pontos(valor):
	pontuacao += valor
	hud.atualizar_pontuacao(pontuacao)

func _ao_inimigo_morrer():
	inimigos_restantes -= 1
	adicionar_pontos(100)

	if inimigos_restantes <= 0:
		onda += 1
		yield(get_tree().create_timer(2.0), "timeout")
		iniciar_onda(onda)

func _ao_jogador_morrer():
	jogo_encerrado = true
	hud.mostrar_fim_de_jogo(pontuacao)
