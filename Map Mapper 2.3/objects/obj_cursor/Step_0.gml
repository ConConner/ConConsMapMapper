//if (image_alpha > 0.25 && a_switch == 0) image_alpha -=0.02;
//if (image_alpha <= 0.25) a_switch = 1;
//if (image_alpha < 0.9 && a_switch == 1) image_alpha +=0.02;
//if (image_alpha >= 0.9) a_switch = 0;

x += (global.xx * 32 - x)/2
y += (global.yy * 32 - y)/2

if (!obj_gameController.canBuild) image_alpha = 0;
else image_alpha = 1;


//changing cursor colour according to selection
var m = ds_grid_get(global.mainGrid,global.xx,global.yy);

if (m == 1) {
	image_blend = c_lime;
	image_speed = 1.5;
}
else {
	image_blend = c_white;
	image_speed = 0.5;
}