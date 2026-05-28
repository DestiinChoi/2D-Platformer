extends Node2D

@export var speed = 200.0
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
	await get_tree().create_timer(5).timeout
	current_speed = 0.0
	global_position = start_position
	
