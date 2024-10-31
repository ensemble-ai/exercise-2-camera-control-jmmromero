class_name TargetFocusLerp
extends CameraControllerBase


@export var lead_speed: float
@export var catchup_delay_duration: float
@export var catchup_speed: float
@export var leash_distance: float

var time_since_stop: float = 0.0


func _ready() -> void:
	super()
	position = target.position


func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
		
	if !target.moving:
		time_since_stop += delta
	else:
		time_since_stop = 0.0
	
	var tpos = target.global_position
	var cpos = global_position
	var horizontal_distance = Vector3(tpos.x - cpos.x, 0, tpos.z - cpos.z)
	
	
		
	if horizontal_distance.length() > 0 and horizontal_distance.length() < leash_distance and target.moving:
		var lead_factor = lead_speed * delta
		var lead_position = tpos + target.velocity.normalized() * leash_distance
		global_position = cpos.lerp(lead_position, lead_factor)
	elif !target.moving and time_since_stop > catchup_delay_duration:
		position = position.lerp(tpos, catchup_speed * delta)
	elif horizontal_distance.length() >= leash_distance:
		var direction = horizontal_distance.normalized()
		global_position = target.global_position - direction * leash_distance

   
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
