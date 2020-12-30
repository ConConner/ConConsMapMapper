//keyboard input
kUp = keyboard_check(vk_up);
kDown = keyboard_check(vk_down);
kLeft = keyboard_check(vk_left);
kRight = keyboard_check(vk_right);
kCtrl = keyboard_check(vk_control);

//movement
xx = device_mouse_x_to_gui(0);
yy = device_mouse_y_to_gui(0);

var _maxspd = spd * border_margin / 5;
var _minspd = 0;
var _storespd = 0;

if (window_has_focus() && obj_gameController.choosingColor != true) {
	
	//mouse movement
	if (kCtrl) {
		if (xx >= view_width - border_margin) {
			_storespd = clamp(spd * (xx - (view_width - border_margin)) / 5,_minspd,_maxspd);
			x += _storespd
		}
		if (xx <= border_margin) {
			_storespd = clamp(spd * (xx*-1 + border_margin) / 5,_minspd,_maxspd);
			x -= _storespd
		}
		if (yy >= view_height - border_margin) {
			_storespd = clamp(spd * (yy - (view_height - border_margin)) / 5,_minspd,_maxspd);
			y += _storespd
		}
		if (yy <= border_margin) {
			_storespd = clamp(spd * (yy*-1 + border_margin) / 5,_minspd,_maxspd);
			y -= _storespd
		}
	}
	
	//arrow keys
	if (kUp) y -= spd * border_margin / 2 / 5;
	if (kDown) y += spd * border_margin / 2 / 5;
	if (kLeft) x -= spd * border_margin / 2 / 5;
	if (kRight) x += spd * border_margin / 2 / 5;
}


x = clamp(x,0+view_width/2,room_width-view_width/2);
y = clamp(y,0+view_height/2,room_width-view_height/2);