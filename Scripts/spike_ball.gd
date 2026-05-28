extends Node2D

<<<<<<< HEAD:spike_ball.gd
@export var speed = 280.0
=======
@export var speed = 200.0
>>>>>>> 61accc2eaa1f1e77c19d2541eb3b0a6d0c7497f4:Scripts/spike_ball.gd
var current_speed = 0.0
@onready var start_position = global_position


func _ready() -> void:
	current_speed = 0.0
	
func _physics_process(delta): 

	position.y += current_speed * delta

func _on_hitbox_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	body.take_damage(3)
		
func _on_player_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$AnimationPlayer.play("shake")
	await $AnimationPlayer.animation_finished
	_fall()

func _fall():
	current_speed = speed
<<<<<<< HEAD:spike_ball.gd
	await get_tree().create_timer(3).timeout
	queue_free()
=======
	await get_tree().create_timer(5).timeout
	current_speed = 0.0
	global_position = start_position
	
>>>>>>> 61accc2eaa1f1e77c19d2541eb3b0a6d0c7497f4:Scripts/spike_ball.gd
