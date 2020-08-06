
mLeft = mouse_check_button_pressed(mb_left);
mRight = mouse_check_button_pressed(mb_right);

if (timer >= 5 && mLeft && !mouse_hovering_over_object()) {
	obj_gameController.alarm[0] = 10;
	obj_gameController.choosingMarker = false;
	instance_destroy();
}

if (timer >= 5 && mLeft && mouse_hovering_over_object()) {
	obj_gameController.alarm[0] = 10;
	obj_gameController.choosingMarker = false;
	ds_grid_set(global.MarkerGrid,gridX,gridY,marker.up);
	instance_destroy();
}

timer ++;