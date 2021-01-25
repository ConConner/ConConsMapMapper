function mouse_hovering_over_object(obj) {
	var _inst = instance_place(mouse_x, mouse_y, obj);
	if (_inst != noone) {
		
		if (mouse_x == clamp(mouse_x, _inst.bbox_left, _inst.bbox_right) && mouse_y == clamp(mouse_y, _inst.bbox_top, _inst.bbox_bottom)) return true;
		else return false;
		
	}


}
