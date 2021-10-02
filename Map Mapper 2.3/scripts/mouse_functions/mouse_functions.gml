function mouse_hovering_over_object(obj) {
	var _inst = instance_place(global.mouse_pos_x, global.mouse_pos_y, obj);
	if (_inst != noone) {
		
		if (global.mouse_pos_x == clamp(global.mouse_pos_x, _inst.bbox_left, _inst.bbox_right) && global.mouse_pos_y == clamp(global.mouse_pos_y, _inst.bbox_top, _inst.bbox_bottom)) return true;
		else return false;
		
	}


}
