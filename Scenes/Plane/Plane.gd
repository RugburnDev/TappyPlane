extends CharacterBody2D

class_name Airplane

const JUMP_POWER : float = -350.0
var _gravity : float = ProjectSettings.get("physics/2d/default_gravity")
@onready var animation_player = $AnimationPlayer
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var engine_sound: AudioStreamPlayer = $EngineSound

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	_fly(delta)
	move_and_slide()
	
	if is_on_floor():
		_die()


func _fly(delta: float) -> void:
	if Input.is_action_just_pressed("Jump"):
		velocity.y = JUMP_POWER
		animation_player.play("jump")
	else:
		velocity.y += _gravity * delta


func _die() -> void:
	print("Plane: died")
	engine_sound.stop()
	animated_sprite_2d.stop()
	set_physics_process(false)
	SignalHub.on_plane_died.emit()
