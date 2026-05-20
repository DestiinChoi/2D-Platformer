extends Sprite2D

@onready var blinkanim : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	blinkanim.play("blink")
