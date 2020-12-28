image_xscale += (global.max_color_scale - image_xscale)/7
image_yscale += (global.max_color_scale - image_yscale)/7

image_xscale = clamp(image_xscale,global.min_color_scale,global.max_color_scale);
image_yscale = clamp(image_yscale,global.min_color_scale,global.max_color_scale);

var _xx = global.half_width +global.viewX;
var _yy = global.half_height +global.viewY;
	
if (circle_menu(8,_xx,_yy,global.color_wheel_radius,global.color_wheel_min_radius) == 6) image_index = 1;
else image_index = 0;