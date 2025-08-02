extends Node2D

@onready var laser: Area2D = $Laser
@onready var laser_animation_player: AnimationPlayer = $Laser/AnimationPlayer

const SCROLL_SPEED : float = 120.0
const OFF_SCREEN_MARGIN : float = 250.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= SCROLL_SPEED * delta
	
	if position.x < get_viewport_rect().position.x - OFF_SCREEN_MARGIN:
		print("WARNING: Pipe: _on_screen_exited seems to have failed")
		_die()


func _die() -> void:
	print("Pipe: removed")
	set_process(false)
	queue_free()

func _on_screen_exited():
	print("Pipe: _on_screen_exited")
	_die()


func _on_pipe_body_entered(body: Node2D) -> void:
	if body is Airplane:
		print("Airplane hit Pipe")
		body._die()


func _on_laser_body_entered(body: Node2D) -> void:
	if body is Airplane:
		print("Airplane thru laser")
		laser.body_entered.disconnect(_on_laser_body_entered)
		laser_animation_player.play("blink")
		SignalHub.on_point_scored.emit()
		
