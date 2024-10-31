class_name FourWayCamera
extends CameraControllerBase

@export var push_ratio: float
@export var pushbox_top_left: Vector2
@export var pushbox_bottom_right: Vector2
@export var speedup_zone_top_left: Vector2
@export var speedup_zone_bottom_right: Vector2

func _ready() -> void:
	super()
	position = target.position

func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_camera_logic

	var tpos = target.global_position
	var cpos = global_position
	var target_speed = target.BASE_SPEED
