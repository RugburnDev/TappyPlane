extends Control

@onready var highscore_label: Label = $MarginContainer/HighscoreLabel

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Jump"):
		GameManager.load_game_scene()

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	highscore_label.text = "%04d" % ScoreManager.high_score
