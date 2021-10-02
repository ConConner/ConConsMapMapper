#macro view view_camera[0]

//keyboard input
kUp = 0//keyboard_check(vk_up);
kDown = 0//keyboard_check(vk_down);
kLeft = 0//keyboard_check(vk_left);
kRight = 0//keyboard_check(vk_right);
kCtrl = 0//keyboard_check(vk_control);

//movement
xx = device_mouse_x_to_gui(0);
yy = device_mouse_y_to_gui(0);

var _maxspd = spd * border_margin / 5;
var _minspd = 0;
var _storespd = 0;

if (window_has_focus() && obj_gameController.cam_lock != true) {
	//arrow keys
	if (kUp) y -= spd * border_margin / 2 / 5;
	if (kDown) y += spd * border_margin / 2 / 5;
	if (kLeft) x -= spd * border_margin / 2 / 5;
	if (kRight) x += spd * border_margin / 2 / 5;
}


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


camera_set_view_size(view,view_width,view_height);