#macro view view_camera[0]

//movement
xx = device_mouse_x_to_gui(0);
yy = device_mouse_y_to_gui(0);

xx = clamp(x,0+view_width/2,global.grid_view_width-view_width/4);
yy = clamp(y,0+view_height/2,global.grid_view_height-view_height/4);


//camlock
if (obj_gameController.cam_lock && cam_x_goal != -1) {
	cam_x_goal = clamp(cam_x_goal,0+view_width/2,global.grid_view_width-view_width/4);
	cam_y_goal = clamp(cam_y_goal,0+view_height/2,global.grid_view_height-view_height/4);
	
	x = lerp(x,cam_x_goal,0.2);
	y = lerp(y,cam_y_goal,0.2);
	
	if (abs(cam_x_goal - x) < 2) x = cam_x_goal;
	if (abs(cam_y_goal - y) < 2) y = cam_y_goal;
}


if (!obj_gameController.cam_lock) {
	cam_x_goal = -1;
	cam_y_goal = -1;
}


//resizing the window
if (global.window_height != global.old_window_height) || (global.window_width != global.old_window_width) {
	
	global.old_window_height = global.window_height;
	global.old_window_width = global.window_width;
	
	resize_window(global.window_width, global.window_height);
}

camera_set_view_size(view,view_width,view_height);