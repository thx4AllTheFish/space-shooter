extends Node2D

var enemy = preload("res://enemy.tscn")
#

func spawn_enemies():
	for x in 9:
		for y in 3:
			var e = enemy.instantiate()
			var pos = Vector2((x * 24) + 24, 16 * 4 + y * 16)
			add_child(e)
			e.position = pos

func enemies_move():
	pass
	#all enemies should move 10px left. then 10 down. then 10 right then 10 right then 10 down then 10 left then 10 left then 10 down

	
# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_enemies()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
