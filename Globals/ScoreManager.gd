extends Node

const SCORE_PATH : String = "user://tappy.tres"

var _high_score : int = 0
var high_score : int:
	get:
		return _high_score
	set(value):
		if value > _high_score:
			_high_score = value
			_save_highscore()


func _ready() -> void:
	_load_highscore()


func _load_highscore() -> void:
	if ResourceLoader.exists(SCORE_PATH):
		var hsc : Highscore_Resource = ResourceLoader.load(SCORE_PATH)
		_high_score = hsc.high_score


func _save_highscore() -> void:
	var hsc : Highscore_Resource = Highscore_Resource.new()
	hsc.high_score = _high_score
	ResourceSaver.save(hsc, SCORE_PATH)
