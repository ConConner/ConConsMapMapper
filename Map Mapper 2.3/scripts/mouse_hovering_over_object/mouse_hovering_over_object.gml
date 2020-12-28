function mouse_hovering_over_object() {
	if (mouse_x == clamp(mouse_x, bbox_left, bbox_right) && mouse_y == clamp(mouse_y, bbox_top, bbox_bottom)) return true;
	else return false;


}
