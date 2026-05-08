extends Node2D

var estrelas = []
var quantidade_estrelas = 80
var tamanho_tela = Vector2.ZERO

func _ready():
	tamanho_tela = get_viewport_rect().size
	randomize()
	gerar_estrelas()

func gerar_estrelas():
	for i in quantidade_estrelas:
		var estrela = {
			"posicao": Vector2(randf() * tamanho_tela.x, randf() * tamanho_tela.y),
			"velocidade": rand_range(40, 160),
			"tamanho": rand_range(1.0, 3.0),
			"brilho": rand_range(0.4, 1.0)
		}
		estrelas.append(estrela)

func _process(delta):
	for estrela in estrelas:
		estrela["posicao"].y += estrela["velocidade"] * delta
		if estrela["posicao"].y > tamanho_tela.y:
			estrela["posicao"].y = 0
			estrela["posicao"].x = randf() * tamanho_tela.x

	update()

func _draw():
	for estrela in estrelas:
		var cor = Color(estrela["brilho"], estrela["brilho"], 1.0, estrela["brilho"])
		draw_circle(estrela["posicao"], estrela["tamanho"], cor)
