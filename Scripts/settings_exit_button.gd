extends MarginContainer

var movement_length : float = 2.0
var speed : float = 7.0

@onready var start_pos : Vector2 = position

func _process(delta: float) -> void:
	var time = Time.get_unix_time_from_system()
	
	var x_pos = ( ( sin(time * speed) - 1 ) ) * movement_length 
	position.x = start_pos.x - x_pos
