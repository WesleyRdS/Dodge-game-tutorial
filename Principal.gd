extends Node

export (PackedScene) var Inimigo
var score

func _ready() -> void:
	randomize()
	iniciar()

func game_over() -> void:
	$pontuacaoTimer.stop()
	$inimigoTimer.stop()
	$HUD.exibir_gameover()
	$Musica.stop()
	$SomMorte.play()

func novo_jogo():
	score = 0
	$jogador.start($posicaoinicial.position)
	$inicioTimer.start()
	$HUD.exibir_mensagem("Prepare-se!")
	$HUD.atualiza_score(score)
	$Musica.play()

func iniciar():
	$pontuacaoTimer.stop()
	$inimigoTimer.stop()
	$HUD.iniciar()

func _on_inicioTimer_timeout() -> void:
	$inimigoTimer.start()
	$pontuacaoTimer.start()

func _on_pontuacaoTimer_timeout() -> void:
	score += 1
	$HUD.atualiza_score(score)
	
func _on_inimigoTimer_timeout() -> void:
	$caminhoInimigo/spawnInimigo.offset = randi()
	var inimigo = Inimigo.instance() #criando uma instancia do objeto inimigo
	add_child(inimigo) #adicionando como um no filho
	var direcao = $caminhoInimigo/spawnInimigo.rotation + PI/2
	inimigo.position = $caminhoInimigo/spawnInimigo.position
	direcao += rand_range(-PI/4, PI/4)
	inimigo.rotation = direcao
	inimigo.linear_velocity = Vector2(rand_range(inimigo.min_speed , inimigo.max_speed) , 0)
	inimigo.linear_velocity = inimigo.linear_velocity.rotated(direcao)
	
