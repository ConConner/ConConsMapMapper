//getting mouse coordinates on grid
global.xx = floor(mouse_x/32);
global.yy = floor(mouse_y/32);

//view and window sizes
global.viewX = camera_get_view_x(view_camera[0]);
global.viewY = camera_get_view_y(view_camera[0]);
global.view_width = camera_get_view_width(view_camera[0]);
global.view_height = camera_get_view_height(view_camera[0]);
global.half_width = global.view_width / 2;
global.half_height = global.view_height / 2;
global.window_width = window_get_width();
global.window_height = window_get_height();
global.window_half_width = global.window_width / 2;
global.window_half_height = global.window_height / 2;


//getting key input
kUp = keyboard_check_direct(vk_up);
kDown = keyboard_check_direct(vk_down);
kLeft = keyboard_check_direct(vk_left);
kRight = keyboard_check_direct(vk_right);
kF12 = keyboard_check_pressed(vk_f12);
	//mouse input
mScrollDown = mouse_wheel_down()
mScrollUp = mouse_wheel_up()
mLeft = mouse_check_button(mb_left);
mRight = mouse_check_button(mb_right);
mLeftReleased = mouse_check_button_released(mb_left);
mLeftPressed = mouse_check_button_pressed(mb_left);
mMiddlePressed = mouse_check_button_pressed(mb_middle);
mMiddle = mouse_check_button(mb_middle);


//timing clicks
if (mLeftPressed) {
	mLeftTimer = 0;
	storeX = global.xx;
	storeY = global.yy;
}
if (mLeft) mLeftTimer ++;


//colors
if (mMiddle && !choosingColor) {
	canBuild = false;
	choosingColor = true;
	storeWindowMouseX = window_mouse_get_x();
	storeWindowMouseY = window_mouse_get_y();
	storeMouseX = mouse_x;
	storeMouseY = mouse_y;
	
	window_mouse_set(global.window_half_width,global.window_half_height);
	var _xx = global.half_width +global.viewX;
	var _yy = global.half_height +global.viewY;
	
	buttonColorPicker = instance_create_layer(_xx,_yy,"Markers",obj_color_wheel_color_picker);
	buttonBlue = instance_create_layer(_xx,_yy,"Markers",obj_color_wheel_blue); buttonAqua = instance_create_layer(_xx,_yy,"Markers",obj_color_wheel_aqua);
	buttonGreen = instance_create_layer(_xx,_yy,"Markers",obj_color_wheel_green); buttonYellow = instance_create_layer(_xx,_yy,"Markers",obj_color_wheel_yellow);
	buttonOrange = instance_create_layer(_xx,_yy,"Markers",obj_color_wheel_orange); buttonRed = instance_create_layer(_xx,_yy,"Markers",obj_color_wheel_red);
	buttonGray = instance_create_layer(_xx,_yy,"Markers",obj_color_wheel_gray); buttonPurple = instance_create_layer(_xx,_yy,"Markers",obj_color_wheel_purple);
}

if (!mMiddle && choosingColor) {
	choosingColor = false;
	canBuild = true;
	
	var _xx = global.half_width +global.viewX;
	var _yy = global.half_height +global.viewY;
	var _storeMouseXX = floor(storeMouseX/32);
	var _storeMouseYY = floor(storeMouseY/32);
	var _m = circle_menu(8,_xx,_yy,global.color_wheel_radius,global.color_wheel_min_radius);
	
	if (_m == 3) colorSelecting = c.blue; if (_m == 2) colorSelecting = c.aqua; if (_m == 1) colorSelecting = c.green;
	if (_m == 0) colorSelecting = c.yellow; if (_m == 7) colorSelecting = c.orange; if (_m == 6) colorSelecting = c.red;
	if (_m == 5) colorSelecting = c.grey; if (_m == 4) colorSelecting = c.purple;
	if (_m == 8) if (ds_grid_get(global.mainGrid,_storeMouseXX,_storeMouseYY) != 0) colorSelecting = ds_grid_get(global.ColorGrid,_storeMouseXX,_storeMouseYY);
	
	if (_m != -1) global.currentColor = colorSelecting;
	colorSelecting = 0;
	
	window_mouse_set(storeWindowMouseX,storeWindowMouseY);
	
	instance_destroy(buttonBlue); instance_destroy(buttonAqua); instance_destroy(buttonGreen); instance_destroy(buttonYellow); 
	instance_destroy(buttonOrange); instance_destroy(buttonRed); instance_destroy(buttonGray); instance_destroy(buttonPurple);
	instance_destroy(buttonColorPicker);
}


	//Building with mouse
if (mLeft) add_tiles();
if (mRight) add_tiles();

if (mLeftReleased) {
	add_tiles();
	global.roomCount = old_roomCount + 1;
	old_roomCount = global.roomCount;
	placed_tile = false;
}

if (!placed_tile && mLeftTimer == 15 && storeX == global.xx && storeY == global.yy) instance_create_layer(global.xx*32,global.yy*32,"Cursor",obj_hold_animation)

surface_free(main_surface);


//debug
if (kF12) debug_on = !debug_on;