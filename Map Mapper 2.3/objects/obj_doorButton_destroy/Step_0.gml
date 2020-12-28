mLeft = mouse_check_button_pressed(mb_left);
mRight = mouse_check_button_pressed(mb_right);

if (timer >= 5 && mLeft && !mouse_hovering_over_object()) {
	obj_gameController.alarm[0] = 10;
	obj_gameController.choosingDoor = false;
	instance_destroy();
}

if (timer >= 5 && mLeft && mouse_hovering_over_object()) {
	obj_gameController.alarm[0] = 10;
	obj_gameController.choosingDoor = false;
	
	//checking tile position
	if (mouseTileX >= 0 && mouseTileX <= 7) {
		ds_grid_set(global.DoorGrid, gridX * 2, gridY * 2, 0);
	}
	else if (mouseTileX >= 25 && mouseTileX <= 32) {
		ds_grid_set(global.DoorGrid, gridX * 2 + 1, gridY * 2, 0);
	}
	else if (mouseTileY >= 0 && mouseTileY <= 7) {
		ds_grid_set(global.DoorGrid, gridX * 2, gridY * 2 + 1, 0);
	}
	else if (mouseTileY >= 25 && mouseTileY <= 32) {
		ds_grid_set(global.DoorGrid, gridX * 2 + 1, gridY * 2 + 1, 0);
	}
	else {
		instance_destroy();
	}

	instance_destroy();
	with (obj_gameController) {
		surface_free(door_surface);
	}
}

timer ++;