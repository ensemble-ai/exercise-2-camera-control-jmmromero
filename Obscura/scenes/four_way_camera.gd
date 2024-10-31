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
		draw_logic()
	
	var tpos = target.global_position
	var cpos = global_position
	
	#boundary checks
	#left
	var diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x - speedup_zone_top_left.x / 2.0)
	if diff_between_left_edges < 0:
		global_position.x -= push_ratio * delta
	#right
	var diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + speedup_zone_bottom_right.x / 2.0)
	if diff_between_right_edges > 0:
		global_position.x += push_ratio * delta
	#top
	var diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - speedup_zone_top_left.y / 2.0)
	if diff_between_top_edges < 0:
		global_position.z -= push_ratio * delta
	#bottom
	var diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + speedup_zone_bottom_right.y / 2.0)
	if diff_between_bottom_edges > 0:
		global_position.z += push_ratio * delta
		
	
	
	
	
	
	
	var diff_between_left_edges_push = (tpos.x - target.WIDTH / 2.0) - (cpos.x - pushbox_top_left.x / 2.0)
	if diff_between_left_edges_push < 0:
		global_position.x += diff_between_left_edges_push
	#right
	var diff_between_right_edges_push = (tpos.x + target.WIDTH / 2.0) - (cpos.x + pushbox_bottom_right.x / 2.0)
	if diff_between_right_edges_push > 0:
		global_position.x += diff_between_right_edges_push
	#top
	var diff_between_top_edges_push = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - pushbox_top_left.y / 2.0)
	if diff_between_top_edges_push < 0:
		global_position.z += diff_between_top_edges_push
	#bottom
	var diff_between_bottom_edges_push = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + pushbox_bottom_right.y / 2.0)
	if diff_between_bottom_edges_push > 0:
		global_position.z += diff_between_bottom_edges_push
		
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float = -speedup_zone_top_left.x / 2
	var right:float = speedup_zone_bottom_right.x / 2
	var top:float = -speedup_zone_top_left.y / 2
	var bottom:float = speedup_zone_bottom_right.y / 2
	
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
	
	var left_push:float = -pushbox_top_left.x / 2
	var right_push:float = pushbox_bottom_right.x / 2
	var top_push:float = -pushbox_top_left.y / 2
	var bottom_push:float = pushbox_bottom_right.y / 2
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(right_push, 0, top_push))
	immediate_mesh.surface_add_vertex(Vector3(right_push, 0, bottom_push))
	
	immediate_mesh.surface_add_vertex(Vector3(right_push, 0, bottom_push))
	immediate_mesh.surface_add_vertex(Vector3(left_push, 0, bottom_push))
	
	immediate_mesh.surface_add_vertex(Vector3(left_push, 0, bottom_push))
	immediate_mesh.surface_add_vertex(Vector3(left_push, 0, top_push))
	
	immediate_mesh.surface_add_vertex(Vector3(left_push, 0, top_push))
	immediate_mesh.surface_add_vertex(Vector3(right_push, 0, top_push))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
