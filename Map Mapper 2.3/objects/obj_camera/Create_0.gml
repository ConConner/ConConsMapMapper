view_width = get_integer("Window width (Min. 800)", 800);
view_height = get_integer("Window height (Min. 800)", 800);

cam_x_goal = -1;
cam_y_goal = -1;

xx = 0;
yy = 0;

window_scale = 1;

window_set_size(view_width*window_scale,view_height*window_scale);
alarm[0]=1;

surface_resize(application_surface,view_width*window_scale,view_height*window_scale);

spd = 1;