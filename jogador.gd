extends Area2D

export var speed = 400
var screen_size

signal hit

func _ready() -> void: #função executa quando a arvore esta pronta
	hide()
	screen_size = get_viewport_rect().size #tamanho da tela de jogo igual o tamanho da viewport

func _process(delta: float) -> void:
	var velocity = Vector2() #plano cartesiano
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	#eixo y na goodot é invertido
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity  = velocity * speed
	#Corrigindo aumento da velocidade do movimento diagonal
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
		$Rastro.emitting = true
	else:
		$AnimatedSprite.stop()
		$Rastro.emitting = false
	#modificando as animações de acordo com a direção
	if velocity.x != 0:
		$AnimatedSprite.animation = "direita"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	
	if velocity.y !=0:
		$AnimatedSprite.animation = "cima"
		$AnimatedSprite.flip_v = velocity.y > 0
		$AnimatedSprite.flip_h = false
		
	position += velocity * delta
	#colocando os limites da tela
	position.x = clamp(position.x,0,screen_size.x)
	position.y = clamp(position.y,0,screen_size.y)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_jogador_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disable", true)
