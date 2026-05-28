extends Control

@export var scene : PackedScene
@onready var ui_sound : AudioStreamPlayer = $UIsound

func _ready() -> void:
	$AnimationPlayer.play("bird")

func _on_return_button_pressed() -> void:
	ui_sound.play()
	await ui_sound.finished
	get_tree().change_scene_to_packed(scene)
