#region setting up
//getting mouse coordinates on grid
global.xx = clamp(floor((mouse_x + global.cam_pos_x) / tile_size), 0, global.grid_width - 1);
global.yy = clamp(floor((mouse_y + global.cam_pos_y) / tile_size), 0, global.grid_height - 1);
real_xx = floor((mouse_x + global.cam_pos_x) / tile_size);
real_yy = floor((mouse_y + global.cam_pos_y) / tile_size);

//view and window sizes
#macro view_half_w = (global.view_width / 2)
#macro view_half_h = (global.view_height / 2)

global.window_width = window_get_width();
global.window_height = window_get_height();
#macro window_half_width  (global.window_width / 2)
#macro window_half_height  (global.window_height / 2)


//getting key input
kUp = keyboard_check_direct(vk_up);
kDown = keyboard_check_direct(vk_down);
kLeft = keyboard_check_direct(vk_left);
kRight = keyboard_check_direct(vk_right);
kF12 = keyboard_check_pressed(vk_f12);
kSpacePressed = keyboard_check_pressed(vk_space);
	//mouse input
mLeft = mouse_check_button(mb_left);
mRight = mouse_check_button(mb_right);
mRightPressed = mouse_check_button_pressed(mb_right);
mRightReleased = mouse_check_button_released(mb_right);
mLeftReleased = mouse_check_button_released(mb_left);
mLeftPressed = mouse_check_button_pressed(mb_left);
mMiddle = mouse_check_button(mb_middle);
#endregion


#region camera

if (kLeft) global.cam_pos_x -= border_margin / 2 / 5;
if (kRight) global.cam_pos_x += border_margin / 2 / 5;
if (kUp) global.cam_pos_y -= border_margin / 2 / 5;
if (kDown) global.cam_pos_y += border_margin / 2 / 5;

global.cam_pos_x = clamp(global.cam_pos_x, 0 - global.view_width / 2, global.grid_width * tile_size - global.view_width / 2);
global.cam_pos_y = clamp(global.cam_pos_y, 0 - global.view_height / 2, global.grid_height * tile_size - global.view_height / 2);

#endregion


#region colors
//if (mMiddle && !choosingColor && canBuild) {
//	canBuild = false;
//	choosingColor = true;
//	cam_lock = true;
	
//	storeWindowMouseX = window_mouse_get_x();
//	storeWindowMouseY = window_mouse_get_y();
//	storeMouseX = mouse_x;
//	storeMouseY = mouse_y;
	
//	window_mouse_set(global.window_half_width,global.window_half_height);
//	var _xx = global.half_width +global.viewX;
//	var _yy = global.half_height +global.viewY;
	
//	buttonColorPicker = instance_create_layer(_xx,_yy,"Markers",obj_color_wheel_color_picker);
//	buttonBlue = instance_create_layer(_xx,_yy,"Markers",obj_color_wheel_blue); buttonAqua = instance_create_layer(_xx,_yy,"Markers",obj_color_wheel_aqua);
//	buttonGreen = instance_create_layer(_xx,_yy,"Markers",obj_color_wheel_green); buttonYellow = instance_create_layer(_xx,_yy,"Markers",obj_color_wheel_yellow);
//	buttonOrange = instance_create_layer(_xx,_yy,"Markers",obj_color_wheel_orange); buttonRed = instance_create_layer(_xx,_yy,"Markers",obj_color_wheel_red);
//	buttonGray = instance_create_layer(_xx,_yy,"Markers",obj_color_wheel_gray); buttonPurple = instance_create_layer(_xx,_yy,"Markers",obj_color_wheel_purple);
//}

//if (!mMiddle && choosingColor) {
//	choosingColor = false;
//	cam_lock = false;
//	canBuild = true;
	
//	var _xx = global.half_width +global.viewX;
//	var _yy = global.half_height +global.viewY;
//	var _storeMouseXX = floor(storeMouseX/32);
//	var _storeMouseYY = floor(storeMouseY/32);
//	var _m = circle_menu(8,_xx,_yy,global.color_wheel_radius,global.color_wheel_min_radius,0);
	
//	if (_m == 3) colorSelecting = c_blue; if (_m == 2) colorSelecting = c_aqua; if (_m == 1) colorSelecting = c_green;
//	if (_m == 0) colorSelecting = c_yellow; if (_m == 7) colorSelecting = c_orange; if (_m == 6) colorSelecting = c_red;
//	if (_m == 5) colorSelecting = c_grey; if (_m == 4) colorSelecting = c_purple;
//	if (_m == 8) if (ds_grid_get(global.mainGrid,_storeMouseXX,_storeMouseYY) != 0) colorSelecting = ds_grid_get(global.ColorGrid,_storeMouseXX,_storeMouseYY);
	
//	if (_m != -1) global.selected_color = colorSelecting;
//	colorSelecting = 0;
	
//	window_mouse_set(storeWindowMouseX,storeWindowMouseY);
	
//	instance_destroy(buttonBlue); instance_destroy(buttonAqua); instance_destroy(buttonGreen); instance_destroy(buttonYellow); 
//	instance_destroy(buttonOrange); instance_destroy(buttonRed); instance_destroy(buttonGray); instance_destroy(buttonPurple);
//	instance_destroy(buttonColorPicker);
//}
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

if (selecting_tile && !choosing_tile_addition) {
	
	if (_rel_mouse_x >= tile_size * 1.5 - edge_size) selected_edge = dir.right;
	else if (_rel_mouse_x <= edge_size) selected_edge = dir.left;
	else if (_rel_mouse_y <= edge_size) selected_edge = dir.up;
	else if (_rel_mouse_y >= tile_size * 1.5 - edge_size) selected_edge = dir.down;
	else selected_edge = dir.none;
}


//bringing up the ring menu
if (mLeftPressed && selecting_tile && selected_edge != dir.none && !choosing_tile_addition) {
	
	clicked_selected_edge = selected_edge;
	choosing_tile_addition = true;
	door_menu_open_timer = 0;
	
	var _xx = global.half_width + global.viewX;
	var _yy = global.half_height + global.viewY;
	
	//spawning the objects
	//markers
	buttonMarker1 = instance_create_layer(_xx,_yy,"Markers",obj_marker_wheel_1); buttonMarker2 = instance_create_layer(_xx,_yy,"Markers",obj_marker_wheel_2);
	buttonMarker3 = instance_create_layer(_xx,_yy,"Markers",obj_marker_wheel_3); buttonMarker4 = instance_create_layer(_xx,_yy,"Markers",obj_marker_wheel_4);
	buttonMarker5 = instance_create_layer(_xx,_yy,"Markers",obj_marker_wheel_5); buttonMarker6 = instance_create_layer(_xx,_yy,"Markers",obj_marker_wheel_6);
	
	buttonMarker5.selected_edge = clicked_selected_edge;
	
	//doors
	buttonDoorBlue = instance_create_layer(_xx,_yy,"Markers",obj_door_wheel_blue); buttonDoorRed = instance_create_layer(_xx,_yy,"Markers",obj_door_wheel_red);
	buttonDoorGreen = instance_create_layer(_xx,_yy,"Markers",obj_door_wheel_green); buttonDoorYellow = instance_create_layer(_xx,_yy,"Markers",obj_door_wheel_yellow);
}


//Clearing Tile
if (mLeftPressed && selected_edge == dir.none && selecting_tile && selection_open_timer >= 1) {
	//unlocking mouse
		cam_lock = false;
		canBuild = true;
		selecting_tile = false;
		door_menu_close_timer = 0;
		
		selected_edge = dir.none
		clicked_selected_edge = dir.none;
		surface_free(door_surface);
		
	ds_grid_set(global.MarkerGrid, tile_xx, tile_yy, 0);
	ds_grid_set(global.DoorGrid, tile_xx * 2, tile_yy * 2, 0);
	ds_grid_set(global.DoorGrid, tile_xx * 2 + 1, tile_yy * 2, 0);
	ds_grid_set(global.DoorGrid, tile_xx * 2, tile_yy * 2 + 1, 0);
	ds_grid_set(global.DoorGrid, tile_xx * 2 + 1, tile_yy * 2 + 1, 0);
}

//Menu Interaction
if (mLeftPressed && choosing_tile_addition && door_menu_open_timer >= 1) {
	
	var _xx = global.half_width +global.viewX;
	var _yy = global.half_height +global.viewY;
	
	var m = circle_menu(6,_xx,_yy,global.marker_wheel_radius,global.marker_wheel_min_radius,30)
	var n = circle_menu(4,_xx,_yy,global.door_wheel_radius,global.door_wheel_min_radius,0)
	var _edge = clicked_selected_edge;
	

	//markers
	if (m == 2) ds_grid_set(global.MarkerGrid,tile_xx,tile_yy,marker.circle);
	if (m == 1) ds_grid_set(global.MarkerGrid,tile_xx,tile_yy,marker.dot);
	if (m == 0) ds_grid_set(global.MarkerGrid,tile_xx,tile_yy,marker.exclamation);
	if (m == 5) ds_grid_set(global.MarkerGrid,tile_xx,tile_yy,marker.boss);
	if (m == 4) ds_grid_set(global.MarkerGrid,tile_xx,tile_yy,marker.left + _edge);
	if (m == 3) ds_grid_set(global.MarkerGrid,tile_xx,tile_yy,marker.start);
	
	//doors
	var _xxOffset = 0;
	var _yyOffset = 0;
	
	var _xxOffset2 = 0;
	var _yyOffset2 = 0;
	
	var _xxOffset3 = 0;
	var _yyOffset3 = 0;
	
	var _edge2 = 0
	
	if (_edge == dir.left) {_xxOffset = 0; _yyOffset = 0; _xxOffset2 = -1; _yyOffset2 = 0; _xxOffset3 = -1; _yyOffset3 = 0; _edge2 = dir.right;}
	if (_edge == dir.right) {_xxOffset = 1; _yyOffset = 0; _xxOffset2 = 2; _yyOffset2 = 0; _xxOffset3 = 1; _yyOffset3 = 0; _edge2 = dir.left;}
	if (_edge == dir.up) {_xxOffset = 0; _yyOffset = 1; _xxOffset2 = 1; _yyOffset2 = -1; _xxOffset3 = 0; _yyOffset3 = -1; _edge2 = dir.down;}
	if (_edge == dir.down) {_xxOffset = 1; _yyOffset = 1; _xxOffset2 = 0; _yyOffset2 = 3; _xxOffset3 = 0; _yyOffset3 = 1; _edge2 = dir.up;}
	
	var _rmNext = ds_grid_get(global.mainGrid, tile_xx + _xxOffset3, tile_yy + _yyOffset3);
	
	if (n == 1) {
		ds_grid_set(global.DoorGrid, tile_xx * 2 + _xxOffset, tile_yy * 2 + _yyOffset, 1 + 5 * _edge);
		if (_rmNext == ID.filled) ds_grid_set(global.DoorGrid, tile_xx * 2 + _xxOffset2, tile_yy * 2 + _yyOffset2, 1 + 5 * _edge2);
	}
	
	if (n == 0) {
		ds_grid_set(global.DoorGrid, tile_xx * 2 + _xxOffset, tile_yy * 2 + _yyOffset, 2 + 5 * _edge);
		if (_rmNext == ID.filled) ds_grid_set(global.DoorGrid, tile_xx * 2 + _xxOffset2, tile_yy * 2 + _yyOffset2, 2 + 5 * _edge2);
	}
	
	if (n == 3) {
		ds_grid_set(global.DoorGrid, tile_xx * 2 + _xxOffset, tile_yy * 2 + _yyOffset, 3 + 5 * _edge);
		if (_rmNext == ID.filled) ds_grid_set(global.DoorGrid, tile_xx * 2 + _xxOffset2, tile_yy * 2 + _yyOffset2, 3 + 5 * _edge2);
	}
	
	if (n == 2) {
		ds_grid_set(global.DoorGrid, tile_xx * 2 + _xxOffset, tile_yy * 2 + _yyOffset, 4 + 5 * _edge);
		if (_rmNext == ID.filled) ds_grid_set(global.DoorGrid, tile_xx * 2 + _xxOffset2, tile_yy * 2 + _yyOffset2, 4 + 5 * _edge2);
	}
	
	
	//closing menu
	cam_lock = false;
	canBuild = true;
	selecting_tile = false;
	left_click_menu_close = true;
	door_menu_close_timer = 0;
		
	selected_edge = dir.none;
	clicked_selected_edge = dir.none;
	choosing_tile_addition = false;
		
	//deleting the buttons
	instance_destroy(buttonMarker1);		instance_destroy(buttonMarker2);		instance_destroy(buttonMarker3);
	instance_destroy(buttonMarker4);		instance_destroy(buttonMarker5);		instance_destroy(buttonMarker6);		
	instance_destroy(buttonDoorBlue);		instance_destroy(buttonDoorRed);		instance_destroy(buttonDoorGreen);		instance_destroy(buttonDoorYellow);
	alarm[0] = 1;
}


	//unlocking the mouse || deselecting the tile
if (obj_camera.x = obj_camera.cam_x_goal && obj_camera.y = obj_camera.cam_y_goal) {
	
	if (!point_in_rectangle(mouse_x,mouse_y,_left - _extra_space,_top - _extra_space,_w + _extra_space,_h + _extra_space) && !choosing_tile_addition) {
		//unlocking mouse
		cam_lock = false;
		canBuild = true;
		selecting_tile = false;
		
		selected_edge = dir.none
		clicked_selected_edge = dir.none;
		surface_free(door_surface);
	}
	
		//unlocking if right clicked
	if (mRightPressed && selecting_tile) {
		cam_lock = false;
		canBuild = true;
		selecting_tile = false;
		right_click_menu_close = true;
		door_menu_close_timer = 0;
		
		selected_edge = dir.none;
		clicked_selected_edge = dir.none;
		choosing_tile_addition = false;
		
		//deleting the buttons
		instance_destroy(buttonMarker1);		instance_destroy(buttonMarker2);		instance_destroy(buttonMarker3);
		instance_destroy(buttonMarker4);		instance_destroy(buttonMarker5);		instance_destroy(buttonMarker6);		
		instance_destroy(buttonDoorBlue);		instance_destroy(buttonDoorRed);		instance_destroy(buttonDoorGreen);		instance_destroy(buttonDoorYellow);
		surface_free(door_surface);
	}
}

#endregion


#region building

if (mRightReleased) {
	right_click_menu_close = false;
}

if (mLeftReleased) {
	left_click_menu_close = false;
}

	//Building with mouse
if (obj_cursor.cursor_mode == curs_mode.on_grid) {
	if (mLeft && !left_click_menu_close) add_tiles();
	if (mRight && !right_click_menu_close) add_tiles();
}

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

#endregion


#region reaching

//reaching goal alpha
remove_marker_cur_alpha = lerp(remove_marker_cur_alpha,remove_marker_goal_alpha,0.15);
selected_edge_cur_alpha = lerp(selected_edge_cur_alpha,selected_edge_goal_alpha,0.15);

#endregion


#region debug

if (kF12) debug_on = !debug_on;

if (debug_on) {
}

#endregion


#region incrementing timers

door_menu_open_timer ++;
door_menu_close_timer ++;
selection_open_timer ++;

#endregion