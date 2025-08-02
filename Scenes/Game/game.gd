extends Node2D

const PIPES = preload("res://Scenes/Pipes/Pipes.tscn")

@onready var pipe_container : Node = $PipeContainer
@onready var upper_pt : Marker2D = $UpperPt
@onready var lower_pt : Marker2D = $LowerPt


# Called when the node enters the scene tree for the first time.
func _ready():
	_spawn_pipes()
	
func _enter_tree() -> void:
	SignalHub.on_plane_died.connect(_on_plane_died)

func _spawn_pipes() -> void:
	print("_spawn_pipes")
	var new_pipe = PIPES.instantiate()
	new_pipe.position = _get_random_spawn()
	pipe_container.add_child(new_pipe)
	
func _get_random_spawn() -> Vector2:
	var spawn_loc = upper_pt.position.lerp(lower_pt.position, randf())
	return spawn_loc

func _on_spawn_timer_timeout() -> void:
	_spawn_pipes()


func _on_plane_died() -> void:
	_game_over()

func _game_over() -> void:
	get_tree().paused = true
