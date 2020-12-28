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
		ds_grid_set(global.DoorGrid, gridX * 2, gridY * 2, 4);
		if (room_left) ds_grid_set(global.DoorGrid, gridX * 2 - 1, gridY * 2, 9);
	}
	
	else if (mouseTileX >= 25 && mouseTileX <= 32) {
		ds_grid_set(global.DoorGrid, gridX * 2 + 1, gridY * 2, 9);
		if (room_right) ds_grid_set(global.DoorGrid, gridX * 2 + 2, gridY * 2, 4);
	}
	
	else if (mouseTileY >= 0 && mouseTileY <= 7) {
		ds_grid_set(global.DoorGrid, gridX * 2, gridY * 2 + 1, 14);
		if (room_up) ds_grid_set(global.DoorGrid, gridX * 2 + 1, gridY * 2 - 1, 19);
	}
	
	else if (mouseTileY >= 25 && mouseTileY <= 32) {
		ds_grid_set(global.DoorGrid, gridX * 2 + 1, gridY * 2 + 1, 19);
		if (room_down) ds_grid_set(global.DoorGrid, gridX * 2, gridY * 2 + 3, 14);
	}

	instance_destroy();
	with (obj_gameController) {
		surface_free(door_surface);
	}
}

timer ++;