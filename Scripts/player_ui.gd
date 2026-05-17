extends CanvasLayer

@onready var health_container = $HealthContainer
var hearts : Array = []

@onready var score_text : Label = $ScoreText

@onready var player = get_parent()


func _ready() -> void:
	hearts = health_container.get_children()
	
	player.on_update_health.connect(_update_hearts)
	player.on_update_score.connect(_update_score)
	var new_health = PlayerStats.health
	_update_hearts(new_health)
	_update_score(PlayerStats.score)

func _update_hearts(health : int):
	for i in len(hearts):
		hearts[i].visible = i < health
	
func _update_score(score : int):
	score_text.text = str(score)













#
