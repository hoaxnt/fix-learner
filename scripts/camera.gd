extends Camera3D

var dragging_object: Node3D = null
var drag_offset: Vector3

func _input(event):
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
				if event.pressed:
						try_grab_object()
				else:
						dragging_object = null

func _physics_process(delta):
		if dragging_object:
				drag_object()


func try_grab_object():
	var from = project_ray_origin(get_viewport().get_mouse_position())
	var to = from + project_ray_normal(get_viewport().get_mouse_position()) * 1000

	var space_state = get_world_3d().direct_space_state
	var ray_params = PhysicsRayQueryParameters3D.create(from, to)
	ray_params.collision_mask = 1
	
	var result = space_state.intersect_ray(ray_params)
	if result and result.has("collider") and result.collider.has_method("set_dragged"):
		dragging_object = result.collider
		dragging_object.set_dragged(true)
		drag_offset = dragging_object.global_transform.origin - result.position


func drag_object():
		var from = project_ray_origin(get_viewport().get_mouse_position())
		var to = from + project_ray_normal(get_viewport().get_mouse_position()) * 1000

		var space_state = get_world_3d().direct_space_state
		var plane = Plane(Vector3.FORWARD, 0)
		var pos = plane.intersects_ray(from, to)

		if pos and dragging_object:
				dragging_object.global_position = pos + drag_offset
