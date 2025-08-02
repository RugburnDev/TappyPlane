extends CanvasLayer

func _switch_scene() -> void:
	GameManager.load_next_scene()

func _on_animation_finished(_anim_name: StringName) -> void:
	queue_free()
