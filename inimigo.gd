extends RigidBody2D

export var min_speed = 150
export var max_speed = 300

func _ready():
	var tipo_inimigos = $AnimatedSprite.frames.get_animation_names()
	#escolhendo tipos de inimigos aleatorios baseado em um sorteio de nomes
	$AnimatedSprite.animation =  tipo_inimigos[randi() % tipo_inimigos.size()]
	


#quando inimigo sai da tela a fila é limpa
func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()



