extends CharacterBody2D

signal on_update_health (health : int)
signal on_update_score (score : int)

@export var move_speed : float = 100
@export var acceleration : float = 50
@export var braking : float = 20
@export var gravity : float = 500
@export var jump_force : float = 200
@export var health = PlayerStats.health

# @export var health : int = 3

var move_input : float 

@onready var sprite : Sprite2D = $Sprite
@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var audio : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var cointext = LabelSettings
@onready var coinanim : AnimationPlayer = $CanvasLayer/CoinUi/CoinAnimation
@onready var cam : Camera2D = $Camera2D
@onready var ui_sound : AudioStreamPlayer = $UIsound

var take_damage_sfx : AudioStream = preload("res://Audio/take_damage.wav")
var coin_sfx : AudioStream = preload("res://Audio/coin.wav")


func _physics_process(delta):
	# gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	elif is_on_floor():
		velocity.y = 0
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


func _process(_delta):
	
	
	if velocity.x != 0:
		sprite.flip_h = velocity.x > 0 
		
	if PlayerStats.health <= 0:
		call_deferred("game_over")

	manage_animation()

	if Input.is_action_pressed("return_to_menu"):
		call_deferred("game_over")
	

	
	if global_position.y > 250:
			
			global_position = Vector2(0 , 0)
			take_damage(1)
			
	


func manage_animation():
	if not anim.current_animation == "dmg":
		if velocity.y < 0:
			anim.play("jump")
		elif velocity.y > 0:
			anim.play("fall")
		elif move_input != 0:
			anim.play("move")
		else: 
			anim.play("idle")


# Take Damage UI and script
func take_damage(amount : int):
	PlayerStats.health -= amount
	on_update_health.emit(PlayerStats.health)
	play_sound(take_damage_sfx)
	
	
		
func game_over():
	var tree = get_tree()
	if tree:
		tree.change_scene_to_file("res://Scenes/menu.tscn")
		
		on_update_health.emit(PlayerStats.health)


# score UI and script
func increase_score(amount : int):
	PlayerStats.score += amount
	on_update_score.emit(PlayerStats.score)
	
	play_sound(coin_sfx)
	coinanim.play("collect")
func damage_flash():
	anim.play("dmg")
	await anim.animation_finished

func play_sound(sound : AudioStream):
	audio.stream = sound
	audio.play()
	
	

func _on_settings_button_pressed() -> void:
	ui_sound.play()
	await ui_sound.finished
	get_tree().paused = true
	$"CanvasLayer/SettinsPopupMenu(INVIS)".show()
	$CanvasLayer/SettingsButton.hide()
	$"CanvasLayer/Sliders (INVIS)".show()
	
func _on_settings_exit_button_pressed() -> void:
	
	$"CanvasLayer/SettinsPopupMenu(INVIS)".hide()
	$CanvasLayer/SettingsButton.show()
	$"CanvasLayer/Sliders (INVIS)".hide()
	get_tree().paused = false
	ui_sound.play()







# :P
