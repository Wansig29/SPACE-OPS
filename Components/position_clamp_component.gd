# Give the component a class name so it can be instanced as a custom node
class_name PositionClampComponent
extends Node2D

@export var actor: Node2D
@export var margin: int = 8

var left_border = 0
var right_border = ProjectSettings.get_setting("display/window/size/viewport_width")

func _process(delta: float) -> void:
	# Ensure actor is assigned before accessing its position
	if actor != null:
		actor.global_position.x = clamp(actor.global_position.x, left_border + margin, right_border - margin)
	else:
		print("Error: Actor is not assigned!")
