extends Area2D

@export var speed = 160.0
var current_speed = 0.0

func _physics_process(delta): 
	position.y += current_speed * delta



func _on_hitbox_area_entered(area: Area2D) -> void:
	if not body.is_in_group("Player"):
		return
	
		body.take_damage(3)
		queue_free()

func _on_player_detect_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		$AnimationPlayer.play("shake")
		
func fall():
	current_speed = speed
	await get_tree().create_timer(5).timeout
	queue_free()
