extends PathFollow3D

@export var step : float = 0.01  # quantité à avancer à chaque “tick”
@export var interval : float = 0.05  # toutes les 0.5 secondes

func _ready():
	# Crée un timer pour avancer le chemin toutes les demi-secondes
	var timer = Timer.new()
	timer.wait_time = interval
	timer.one_shot = false
	timer.autostart = true
	add_child(timer)
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))

func _on_timer_timeout():
	progress_ratio += step
	if progress_ratio > 1.0:
		progress_ratio = 1.0  # ou 0 pour boucler
