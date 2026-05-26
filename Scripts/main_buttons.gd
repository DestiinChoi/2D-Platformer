extends MarginContainer

@onready var ui_sound : AudioStreamPlayer = $"../UIsound"
@onready var ui_anim : AnimationPlayer = $"../AnimationPlayer"

@export var settings_menu : MarginContainer
@export var characters_menu : MarginContainer
@export var main_menu : VBoxContainer
@export var sliders : VBoxContainer

func _ready() -> void:
	main_menu.visible = true
	settings_menu.visible = false
	sliders.visible = false

func toggle_visibilty(object):
	if object.visible:
		object.visible = false
	else:
		object.visible = true
	

func _on_settings_button_pressed() -> void:
	ui_sound.play()
	ui_anim.play("settings_open")
	
func _on_settings_exit_button_pressed() -> void:
	ui_sound.play()
	ui_anim.play("settings_close")
	

func _on_characters_button_pressed() -> void:
	ui_sound.play()
	ui_anim.play("characters_open")


func _on_character_exit_button_pressed() -> void:
	ui_sound.play()
	ui_anim.play("characters_close")
