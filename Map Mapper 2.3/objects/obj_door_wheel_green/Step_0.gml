image_xscale += (global.max_door_scale - image_xscale)/7
image_yscale += (global.max_door_scale - image_yscale)/7

image_xscale = clamp(image_xscale,global.min_door_scale,global.max_door_scale);
image_yscale = clamp(image_yscale,global.min_door_scale,global.max_door_scale);

var _xx = global.half_width +global.viewX;
var _yy = global.half_height +global.viewY;
	
if (circle_menu(4,_xx,_yy,global.door_wheel_radius,global.door_wheel_min_radius,0) == 3) image_index = 1;
else image_index = 0;