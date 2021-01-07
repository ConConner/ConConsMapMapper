#region setting up
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
#endregion


#region colors
if (mMiddle && !choosingColor && canBuild) {
	canBuild = false;
	choosingColor = true;
	cam_lock = true;
	
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
	cam_lock = false;
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
#endregion


#region selecting tile
if (!selecting_tile) {
	tile_xx = global.xx;
	tile_yy = global.yy;
	
	tile_xscale_goal = 1;
	tile_yscale_goal = 1;
}

	//reaching scale
tile_xscale = lerp(tile_xscale,tile_xscale_goal,0.22)
tile_yscale = lerp(tile_yscale,tile_yscale_goal,0.22)

	//locking mouse
if (selecting_tile) {
	if (obj_camera.x != obj_camera.cam_x_goal || obj_camera.y != obj_camera.cam_y_goal) {
	
		var mouse_xx = obj_camera.cam_x_goal - camera_get_view_x(view);
		var mouse_yy = obj_camera.cam_y_goal - camera_get_view_y(view);
	
		window_mouse_set(mouse_xx,mouse_yy);
	}
}

	//checking mouse on tile
var _top = tile_yy * tile_size - tile_size/4;
var _left = tile_xx * tile_size - tile_size/4;
var _w = _left + tile_size * 1.5;
var _h = _top + tile_size * 1.5;
var _extra_space = 12;

var _rel_mouse_x = mouse_x - _left;
var _rel_mouse_y = mouse_y - _top;

if (selecting_tile) {
	
	if (_rel_mouse_x >= tile_size * 1.5 - edge_size) selected_edge = dir.right;
	else if (_rel_mouse_x <= edge_size) selected_edge = dir.left;
	else if (_rel_mouse_y <= edge_size) selected_edge = dir.up;
	else if (_rel_mouse_y >= tile_size * 1.5 - edge_size) selected_edge = dir.down;
	else selected_edge = dir.none;
}

	//unlocking the mouse || deselecting the tile
if (obj_camera.x = obj_camera.cam_x_goal && obj_camera.y = obj_camera.cam_y_goal) {
	if (!point_in_rectangle(mouse_x,mouse_y,_left - _extra_space,_top - _extra_space,_w + _extra_space,_h + _extra_space)) {
		//unlocking mouse
		cam_lock = false;
		canBuild = true;
		selecting_tile = false;
	}
}
#endregion


	//Building with mouse
if (mLeft) add_tiles();
if (mRight) add_tiles();

if (mLeftReleased) {
	add_tiles();
	global.roomCount = old_roomCount + 1;
	old_roomCount = global.roomCount;
	placed_tile = false;
}

//checking if clicked and then moved
if (mLeftPressed) {
	click_xx = global.xx;
	click_yy = global.yy;
	click_moved = false;
}
if (mLeft) {
	if (click_xx != global.xx) click_moved = true;
	if (click_yy != global.yy) click_moved = true;
}


//reaching goal alpha
remove_marker_cur_alpha = lerp(remove_marker_cur_alpha,remove_marker_goal_alpha,0.15);
selected_edge_cur_alpha = lerp(selected_edge_cur_alpha,selected_edge_goal_alpha,0.15);


//debug
if (kF12) debug_on = !debug_on;