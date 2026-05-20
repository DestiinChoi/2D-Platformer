extends TextureRect

var bob_height : float = 5.0
var bob_speed : float = 3.0

@onready var start_pos : Vector2 = global_position

func _process(delta: float) -> void:
	var time = Time.get_unix_time_from_system()
	
	var y_pos = ((1 + sin(time * bob_speed))) * bob_height 
	global_position.y = start_pos.y - y_pos
	
