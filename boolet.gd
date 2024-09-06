extends Area2D

@export var speed = -250

func start(pos):
	position = pos



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	#free() deletes something. it frees it from memory. if you do this without waiting to be sure another object isnt trying to reference it, your compy crash :( . queue_free() is better


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		area.explode()
		queue_free()
