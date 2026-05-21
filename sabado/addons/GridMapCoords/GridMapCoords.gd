@tool
extends EditorPlugin 

const P_HOLDER_SYSTEM_FONT = preload("uid://cqmrhx0ybf4ux")

var grid_map_editor: GridMapEditorPlugin

func _enable_plugin() -> void:
	set_process(true)


func _handles(object: Object) -> bool:
	if object is GridMap:
		var root = get_editor_interface().get_resource_filesystem().get_node("/root")
		grid_map_editor = root.find_children("", "GridMapEditorPlugin", true, false)[0]
		
		return true

	return false

func _process(delta: float) -> void:
	update_overlays()
	pass

func _forward_3d_draw_over_viewport(viewport_control: Control) -> void:
	var sel = grid_map_editor.get_selected_cells()
	if sel.size() <= 0: return
	var pos = viewport_control.get_begin()
	pos.y = viewport_control.size.y -5
	pos.x += 5
	
	viewport_control.draw_string(P_HOLDER_SYSTEM_FONT, pos, str(sel[0]),HORIZONTAL_ALIGNMENT_LEFT)
	#viewport_control.draw_circle(pos,200, Color.RED)
