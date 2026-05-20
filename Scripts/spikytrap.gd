extends Area2D

@onready var spikyanim : AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
		
	body.take_damage(1)
	body.damage_flash()
	
	
func _ready() -> void:
	if get_tree().get_current_scene().get_name() == "level_3":
		spikyanim.play("Spiky")
