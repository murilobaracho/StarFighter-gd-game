extends CanvasLayer

onready var rotulo_pontuacao = $ScoreLabel
onready var rotulo_onda = $WaveLabel
onready var rotulo_vida = $HealthLabel
onready var painel_fim_de_jogo = $GameOverPanel
onready var rotulo_pontuacao_final = $GameOverPanel/FinalScoreLabel

func _ready():
	painel_fim_de_jogo.visible = false
	atualizar_pontuacao(0)
	atualizar_onda(1)
	atualizar_vida(3)

func atualizar_pontuacao(valor):
	rotulo_pontuacao.text = "Pontos: " + str(valor)

func atualizar_onda(valor):
	rotulo_onda.text = "Onda: " + str(valor)

func atualizar_vida(valor):
	var coracoes = ""
	for i in valor:
		coracoes += "♥ "
	rotulo_vida.text = coracoes

func mostrar_fim_de_jogo(pontuacao_final):
	painel_fim_de_jogo.visible = true
	rotulo_pontuacao_final.text = "Pontuação final: " + str(pontuacao_final)

func _ao_clicar_reiniciar():
	get_tree().reload_current_scene()
