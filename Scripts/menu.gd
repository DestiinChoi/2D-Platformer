extends Control

@onready var timer : Timer = $Timer
@onready var water : TileMapLayer = $Waterfall

func _ready() -> void:
	timer.start()

func _on_timer_timeout() -> void:
	if not water.visible:
		water.visible = true
	elif water.visible:
		water.visible = false
	

func _on_play_button_pressed() -> void:
	PlayerStats.score = 0
	PlayerStats.health = 5
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()














#
