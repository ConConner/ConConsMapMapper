x += (global.xx * 32 - x)/2		//updating cursor position
y += (global.yy * 32 - y)/2

if (!obj_gameController.canBuild) image_alpha = 0;
else image_alpha = 1;


//changing cursor colour according to selection
var m = ds_grid_get(global.mainGrid,global.xx,global.yy);

if (m == 1) {		//selected
	image_blend = c_lime;
	image_speed = 2;
	sprite_index = spr_cursor_selected;
}
else {		//unselected
	image_blend = c_white;
	image_speed = 0.5;
	sprite_index = spr_cursor_unselected;
}

if (mouse_check_button(mb_right)) {
	sprite_index = spr_cursor_del
	image_blend = c_white;
	image_speed = 2;
}