class_name HorizontalAutoScroll
extends CameraControllerBase

@export var top_left: Vector2
@export var bottom_right: Vector2
@export var autoscroll_speed: Vector3
var box_position := Vector3()
var box_center_x = (top_left.x + bottom_right.x) / 2
var box_center_z = (top_left.y + bottom_right.y) / 2

func _ready() -> void:
	super()
	box_position = Vector3(box_center_x, 0, box_center_z)
	


func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	box_position.x += autoscroll_speed.x * delta
	box_position.z += autoscroll_speed.z * delta
	global_position.x = box_position.x
	global_position.z = box_position.z
	
	
	target.position.x += autoscroll_speed.x * delta
	target.position.z += autoscroll_speed.z * delta
		
	var tpos = target.global_position
	var cpos = global_position
	
	if (tpos.x - target.WIDTH / 2.0) < (cpos.x - top_left.x / 2.0):
		target.global_position.x = cpos.x + (target.WIDTH / 2.0) - (top_left.x / 2.0)

	if (tpos.x + target.WIDTH / 2.0) > (cpos.x + top_left.x / 2.0):
		target.global_position.x = cpos.x - (target.WIDTH / 2.0) + (top_left.x / 2.0)

	if (tpos.z - target.HEIGHT / 2.0) < (cpos.z - bottom_right.y / 2.0):
		target.global_position.z = cpos.z + (target.HEIGHT / 2.0) - (bottom_right.y / 2.0)

	if (tpos.z + target.HEIGHT / 2.0) > (cpos.z + bottom_right.y / 2.0):
		target.global_position.z = cpos.z - (target.HEIGHT / 2.0) + (bottom_right.y / 2.0)

		
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float = -top_left.x / 2
	var right:float = top_left.x / 2
	var top:float = -bottom_right.y / 2
	var bottom:float = bottom_right.y / 2
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	await get_tree().process_frame
	mesh_instance.queue_free()
