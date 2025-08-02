extends Node

const GAME = preload("res://Scenes/Game/Game.tscn")
const MAIN = preload("res://Scenes/Main/Main.tscn")
const COMPLEX_TRANSITION = preload("res://Scenes/ComplexTransition/complex_transition.tscn")

var next_scene: PackedScene

func _add_complex_transition() -> void:
	add_child(COMPLEX_TRANSITION.instantiate())

func load_game_scene() -> void:
	next_scene = GAME
	_add_complex_transition()
	
func load_main_scene() -> void:
	next_scene = MAIN
	_add_complex_transition()
	
func load_next_scene() -> void:
	get_tree().change_scene_to_packed(next_scene)
