extends KinematicBody2D

export var speed = 400

# animation variables
var is_running : bool = false
var facing_left : bool = false

func _process(delta):
	move_player(delta)
	set_player_animation()

func set_player_animation() -> void:
	if is_running:
		$SpritePlayer.play("run")
	else:
		$SpritePlayer.play("idle")
	
	$SpritePlayer.flip_h = facing_left
	
func move_player(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		is_running = true
	else:
		is_running = false

	# Utiliza move_and_slide para gestionar las colisiones
	velocity = move_and_slide(velocity)

	if velocity.x < 0:
		facing_left = true
	elif velocity.x > 0:
		facing_left = false
