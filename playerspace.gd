extends Area2D

@export var cooldown = 0.25
@export var bullet_scene : PackedScene
#make a variable called bullet_scene. it will hold a saved scene.
@export var speed = 150
#makes a variable called speed sets it to 150. @export puts it in the inspector
@onready var screensize = get_viewport_rect().size
#onready makes a variable but only sets it to somehting when the game runs.
var can_shoot = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"timer gun cooldown".wait_time = cooldown

func shoot():
	if not can_shoot:
		return
	can_shoot = false
	$"timer gun cooldown".start()
	var b = bullet_scene.instantiate()
	#make a new object of this scene. make it a child of something (if u want it independant from the ship, maybe the world
	get_tree().root.add_child(b)
	b.start(position + Vector2(0,-8))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("shoot"):
		shoot()
	var input = Input.get_vector("left", "right", "up", "down")
	position += input * speed * delta
	position = position.clamp(Vector2.ZERO, screensize)
		#$ = getnode
	if input.x > 0:
		$Sprite2D.frame = 2
		$AnimatedSprite2D.animation = "right"
	elif input.x < 0:
		$Sprite2D.frame = 0
		$AnimatedSprite2D.animation = "left"
	else:
		$Sprite2D.frame = 1
		$AnimatedSprite2D.animation = "forward"
	#TO DO !!!!!!!!!!!!!!! use ship size to fix clamp
	#if u pass clamp 2 numbers, itll clamp your value btwn the numbers
	#delta = timestep?


func _on_timer_gun_cooldown_timeout():
	can_shoot = true


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		$Sprite2D.hide()
		$AnimatedSprite2D.hide()
		$explosion.play("default")
		set_process(false)
		await $explosion.animation_finished
		queue_free()
		#when the ship touches an enemy, it needs to play the explosion animation one time and then end it.
