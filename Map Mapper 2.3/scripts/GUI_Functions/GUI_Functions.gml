function circle_menu(total_options,circle_x,circle_y,circle_radius,min_radius,dir_offset) {
	
	// Select option from circle menu
	var option_angle_range = (360/total_options);
	var dis = point_distance( circle_x , circle_y , global.mouse_pos_x , global.mouse_pos_y );
	if( dis < circle_radius && dis > min_radius )
	{
	    var dir = point_direction( circle_x , circle_y , global.mouse_pos_x , global.mouse_pos_y ) + dir_offset;
		if (dir > 360) dir -= 360
		if (dir < 0) dir += 360
	    return( floor( dir / option_angle_range ) );
	}
	else
	{
		if (dis > circle_radius) {
			return( -1 )
		}
		
		if (dis < min_radius) {
			return( total_options );
		}
	}
}


function draw_nine_slice( spr, _x1, _y1, _x2, _y2) {
	
	var _size = sprite_get_width(spr) / 3;
	var _w = _x2 - _x1;
	var _h = _y2 - _y1;
	
	
	//Corners
	//top left
	draw_sprite_part(spr, 0, 0, 0, _size, _size, _x1, _y1);
	//top right
	draw_sprite_part(spr, 0, _size * 2, 0, _size, _size, _x1 + _w - _size, _y1);
	//bottom left
	draw_sprite_part(spr, 0, 0, _size*2, _size, _size, _x1, _y1 + _h - _size);
	//bottom right
	draw_sprite_part(spr, 0, _size * 2, _size * 2, _size, _size, _x1 + _w - _size, _y1 + _h - _size);
	
	//Edges
	//left edge
	draw_sprite_part_ext(spr, 0, 0, _size, _size, 1, _x1, _y1 + _size, 1, _h - (_size*2), c_white, image_alpha); 
	//right edge
	draw_sprite_part_ext(spr, 0, _size * 2, _size, _size, 1, _x1 + _w - _size, _y1 + _size, 1, _h - (_size*2), c_white, image_alpha);
	//top edge
	draw_sprite_part_ext(spr, 0, _size, 0, 1, _size, _x1 + _size, _y1, _w - (_size*2), 1, c_white, image_alpha);
	//bottom edge
	draw_sprite_part_ext(spr, 0, _size, _size * 2, 1, _size, _x1 + _size, _y1 + _h - _size, _w - (_size*2), 1, c_white, image_alpha);
	
	//Middle
	draw_sprite_part_ext(spr, 0, _size, _size, 1, 1, _x1 + _size, _y1 + _size, _w - (_size*2), _h - (_size*2), c_white, image_alpha);
}
	
	
function make_button(_x, _y, _spr, _menu_level) {
	
	//Creates a new button at the goal coordinates and with the set sprite
	
	var button_id = new button_create(_x, _y, _spr, _menu_level);
	ds_list_add(global.button_list, button_id);
	if (button_id != noone) return(button_id);
	else return(-1);
	
}


function button_check() {
	
	//returns the button ID currently hovered over by the mouse
	
	for(var i = 0; i < ds_list_size(global.button_list); i++) {
		
		var _id = ds_list_find_value(global.button_list, i);
		if (_id != 0) {
			
			if(_id.check(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0))) {
					if (_id.active) return(_id);
			}
		}
	}
	return(0);
}
	
	
function button_update() {
	
	//updates and draws the button
	
	for(var i = 0; i < ds_list_size(global.button_list); i++) {
		
		var _id = ds_list_find_value(global.button_list, i);
		if (_id != 0) {
			if (_id.button_enabled == true) {
				_id.move();
				if (_id.menu_level != obj_gameController.current_menu) {
					_id.goal_alpha = 0;
					_id.deactivate();
				}
				_id.fade();
				_id.draw();
			}
			
		}
	}
}


function remove_button(_button) {
	
	//removes a button
	//returns true if sucessfully deleted
	
	if (is_struct(_button)) {
		
		var _button_pos = ds_list_find_index(global.button_list,_button);
		ds_list_delete(global.button_list,_button_pos);
		delete _button;
		return(true);
	}
	else return(false);
}
	

function visualize_buttons() { //draws outlines at every button position
	
	for(var i = 0; i < ds_list_size(global.button_list); i++) {
		
		var _id = ds_list_find_value(global.button_list, i);
		if (_id != 0) {
			
			draw_rectangle_color(_id.x, _id.y, _id.x + _id.button_width, _id.y + _id.button_height, c_aqua, c_aqua, c_aqua, c_aqua, true);
			
		}
	}
	
}


function draw_checkbox(_x, _y, _value) {

	draw_sprite(spr_checkbox, _value, _x, _y);

}
	

function draw_text_button(_x, _y, _w, _h, _txt = "") { //draws a box with a centered text in it
	
	var old_halign = draw_get_halign();
	var old_valign = draw_get_valign();
	
	//button outline
	draw_nine_slice(spr_edge_nineslice, _x, _y, _x + _w, _y + _h);
	
	//text
	var _halfw = _w / 2;
	var _halfh = _h / 2;
	draw_set_halign(fa_center);	//centering text
	draw_set_valign(fa_middle);
	
	draw_text(_x + _halfw, _y + _halfh, _txt);
	
	draw_set_halign(old_halign);	//resetting aligns
	draw_set_valign(old_valign);
}
	

function resize_window(new_width, new_height) {
	
	//capping width and height
	var invalid = false;
	if (new_width < 800 || new_width > global.display_width) invalid = true;
	if (new_width < 800 || new_width > global.display_width) invalid = true;
	
	new_width = clamp(new_width, 800, global.display_width);
	new_height = clamp(new_height, 800, global.display_height);
	
	view_width = new_width;
	view_height = new_height;
	window_set_size(view_width*window_scale,view_height*window_scale);
	surface_resize(application_surface,view_width*window_scale,view_height*window_scale);
}