extends ParallaxBackground

@onready var space_layer: ParallaxLayer = %SpaceLayer
@onready var far_star_layer: ParallaxLayer = %FarStarLayer
@onready var close_star_layer: ParallaxLayer = %CloseStarLayer


func _process(delta: float) -> void:
	space_layer.motion_offset.y += 2 * delta
	far_star_layer.motion_offset.y += 5 * delta
	close_star_layer.motion_offset.y += 20 * delta
	
