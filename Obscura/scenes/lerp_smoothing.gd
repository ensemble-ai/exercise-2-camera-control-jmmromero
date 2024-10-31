class_name LerpSmoothing
extends CameraControllerBase


@export var follow_speed: float
@export var catchup_speed: float
@export var leash_distance: float


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
	var horizontal_distance = Vector3(tpos.x - cpos.x, 0, tpos.z - cpos.z)
   
	if horizontal_distance.length() > 0 and horizontal_distance.length() < leash_distance and target.moving:
		var follow_factor = follow_speed * delta
		global_position = cpos.lerp(tpos, follow_factor)
	elif target.moving == false:
		var catchup_factor = catchup_speed * delta
		global_position = cpos.lerp(tpos, catchup_factor)
	elif horizontal_distance.length() >= leash_distance:
		var super_catch_up = target.speed * delta
		global_position = cpos.lerp(tpos, super_catch_up)
	
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()

	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	var half_length := 2.5

	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	
	immediate_mesh.surface_add_vertex(Vector3(-half_length, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(half_length, 0, 0))
	
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -half_length))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, half_length))
	
	immediate_mesh.surface_end()
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)

	await get_tree().process_frame
	mesh_instance.queue_free()
