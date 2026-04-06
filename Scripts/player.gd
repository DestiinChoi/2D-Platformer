extends CharacterBody2D

signal on_update_health (health : int)
signal on_update_score (score : int)

@export var move_speed : float = 100
@export var acceleration : float = 50
@export var braking : float = 20
@export var gravity : float = 500
@export var jump_force : float = 200

@export var health : int = 3

var move_input : float 

@onready var sprite : Sprite2D = $Sprite
@onready var anim : AnimationPlayer = $AnimationPlayer

func _physics_process(delta):
	# gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# get move input
	move_input = Input.get_axis("move_left", "move_right")
	
	# movement
	if move_input != 0:
		velocity.x = lerp(velocity.x, move_input * move_speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, braking * delta)
	
	# jumping
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
	
	move_and_slide()


func _process(delta):
	if velocity.x != 0:
		sprite.flip_h = velocity.x > 0 

	if global_position.y > 200:
		game_over()
	
	
	manage_animation()

func manage_animation():
	if not is_on_floor():
		anim.play("jump")
	elif move_input != 0:
		anim.play("move")
	else: 
		anim.play("idle")

func take_damage(amount : int):
	health -= amount
	on_update_health.emit(health)
	_damage_flash()
	
	if health <= 0:
		call_deferred("game_over")
		
func game_over():
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")

func increase_score(amount : int):
	PlayerStats.score += amount
	on_update_score.emit(PlayerStats.score)

func _damage_flash():
	sprite.modulate = Color.RED
	await get_tree().create_timer(0.05).timeout
	sprite.modulate = Color.WHITE
















# :P
