extends CanvasLayer

signal start_game

func exibir_mensagem(text):
	$messageLabel.text = text
	$messageLabel.show()
	$messageTimer.start()
	
func exibir_gameover():
	exibir_mensagem("Fim de Jogo!")
	yield($messageTimer,"timeout") #espera que algo aconteça para que execute outra coisa
	
	$messageLabel.text = "Desvie e sobreviva aos monstros!"
	$messageLabel.show()
	yield(get_tree().create_timer(1), "timeout")
	$startButton.show()
	
func iniciar():
	$messageLabel.text = "Desvie e sobreviva aos monstros!"
	$messageLabel.show()
	yield(get_tree().create_timer(1), "timeout")
	$startButton.show()

func atualiza_score(score):
	$scoreLabel.text = str(score)
	
func _on_startButton_pressed() -> void:
	$startButton.hide()
	emit_signal("start_game")
	
func _on_messageTimer_timeout() ->void:
	$messageLabel.hide()
