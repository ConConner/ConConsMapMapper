//getting mouse coordinates on grid
global.xx = floor(mouse_x/32);
global.yy = floor(mouse_y/32);


//getting key input
cUp = keyboard_check_direct(vk_up);
cDown = keyboard_check_direct(vk_down);
cLeft = keyboard_check_direct(vk_left);
cRight = keyboard_check_direct(vk_right);
cPlace = keyboard_check_direct(vk_space);
cRemove = keyboard_check_direct(vk_control);
cNextRoom = keyboard_check_direct(vk_shift);
	//mouse input
scroll_down = mouse_wheel_down()
scroll_up = mouse_wheel_up()
mLeft = mouse_check_button(mb_left);
mRight = mouse_check_button(mb_right);
mLeftReleased = mouse_check_button_released(mb_left);
mLeftPressed = mouse_check_button_pressed(mb_left);
mMiddlePressed = mouse_check_button_pressed(mb_middle);



//timing cursor
if (cUp) cUpTimer ++ else cUpTimer = 0;
if (cDown) cDownTimer ++ else cDownTimer = 0;
if (cLeft) cLeftTimer ++ else cLeftTimer = 0;
if (cRight) cRightTimer ++ else cRightTimer = 0;
if (cNextRoom) cNextRoomTimer ++ else cNextRoomTimer = 0;
var cPause = 30;
	//timing clicks
if (mLeftPressed) {
	mLeftTimer = 0;
	storeX = global.xx;
	storeY = global.yy;
}
if (mLeft) mLeftTimer ++;



//acting on key/mouse input
if (cUpTimer = 1 || cUpTimer >= cPause) && (cursor_spawned && global.cY !=0) global.cY --;
if (cDownTimer = 1 || cDownTimer >= cPause) && (cursor_spawned && global.cY !=global.grid_size - 1) global.cY ++;
if (cLeftTimer = 1 || cLeftTimer >= cPause) &&  (cursor_spawned && global.cX != 0) global.cX --;
if (cRightTimer = 1 || cRightTimer >= cPause) &&  (cursor_spawned && global.cX !=global.grid_size - 1) global.cX ++;
if (cNextRoomTimer = 1) global.roomCount ++;

//colors
if (mMiddlePressed && !choosingColor) {
	instance_destroy(obj_cursor);
	cursor_spawned = false;
	
	canBuild = false;
	choosingColor = true;
	var storeXX = mouse_x - 16;
	var storeYY = mouse_y - 16;
	
	var button_blue = instance_create_layer(storeXX - 32, storeYY + 12, "Markers", obj_button_blue);
	var button_aqua = instance_create_layer(storeXX - 32, storeYY - 12, "Markers", obj_button_aqua);
	var button_green = instance_create_layer(storeXX - 12, storeYY - 32, "Markers", obj_button_green);
	var button_yellow = instance_create_layer(storeXX + 12, storeYY - 32, "Markers", obj_button_yellow);
	var button_orange = instance_create_layer(storeXX + 32, storeYY + 12, "Markers", obj_button_orange);
	var button_red = instance_create_layer(storeXX + 32, storeYY - 12, "Markers", obj_button_red);
	var button_gray = instance_create_layer(storeXX + 12, storeYY + 32, "Markers", obj_button_gray);
	var button_purple = instance_create_layer(storeXX - 12, storeYY + 32, "Markers", obj_button_purple);
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



//spawning Cursor
//if (cUp || cDown || cLeft || cRight || cPlace || cRemove) && (!cursor_spawned) {
//	instance_create_layer(global.cX*32,global.cY*32,"Cursor",obj_cursor);
//	cursor_spawned = true;
//}

//Building with Cursor
//add_tiles(true,false);