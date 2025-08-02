extends Control

@onready var press_space: Label = $MarginContainer/PressSpace
@onready var game_over: Label = $MarginContainer/GameOver
@onready var timer: Timer = $Timer
@onready var score_label: Label = $MarginContainer/score_label
@onready var game_over_sound: AudioStreamPlayer = $GameOverSound
@onready var score_sound: AudioStreamPlayer = $ScoreSound

var _score : int = 0

func _ready() -> void:
	_score = 0
	score_label.text = "%04d" % _score

func _enter_tree() -> void:
	SignalHub.on_plane_died.connect(_on_plane_died)
	SignalHub.on_point_scored.connect(_on_point_scored)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Exit"):
		GameManager.load_main_scene()
	elif press_space.visible and event.is_action_pressed("Jump"):
		GameManager.load_main_scene()

func _on_plane_died() -> void:
	game_over_sound.play()
	game_over.show()
	ScoreManager.high_score = _score
	timer.start()
	
func _on_point_scored() -> void:
	score_sound.play()
	_score += 1
	score_label.text = "%04d" % _score

func _on_timer_timeout() -> void:
	game_over.hide()
	press_space.show()
