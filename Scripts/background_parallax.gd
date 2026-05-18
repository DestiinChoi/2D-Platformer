extends Node2D

var parallax : float = 0.8
@onready var player = $"../Player"

func _process(delta):
	global_position.x = player.global_position.x * parallax
	global_position.y = player.global_position.y
