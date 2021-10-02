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
	

function draw_checkbox(_x, _y, _value) {

	draw_sprite(spr_checkbox, _value, _x, _y);

}