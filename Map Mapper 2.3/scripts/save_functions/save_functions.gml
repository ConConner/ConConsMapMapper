function save_map(file_name) {
	
	//checking if the directory is valid
	var wd_length = string_length(working_directory);
	var directory_length = string_length(file_name);
	var excess_length = clamp(directory_length - wd_length, 0, infinity);
	
	var check_directory = string_delete(file_name, wd_length + 1, excess_length);
	if (check_directory == working_directory) {
		add_text_message("!!! YOU CANT SAVE YOUR MAP IN THE PROGRAM DIRECTORY !!!", 4, c_yellow)
	} else {
	
		if (file_name != "") {
	
			//converting grid into array
			var _grid_width = global.grid_width;
			var _grid_height = global.grid_height;
			_converted_array[global.grid_width,global.grid_height] = -1;
	
			for (var i = 0; i < _grid_width; i++) {
				for (var j = 0; j < _grid_height; j++) {
			
					_converted_array[i, j] = ds_grid_get(global.tile_grid, i, j);
			
				}
			}
	
			//converting the array to JSON string and writing it into a file
			var _string = json_stringify(_converted_array);
			var _file_id = file_text_open_write(file_name)
	
			file_text_write_string(_file_id, save_system_version); //version number
			file_text_writeln(_file_id);
			file_text_write_real(_file_id, _grid_width); //grid width
			file_text_writeln(_file_id);
			file_text_write_real(_file_id, _grid_height); //grid height
			file_text_writeln(_file_id);
			file_text_write_string(_file_id, marker_url); //marker url
			file_text_writeln(_file_id);
	
			file_text_write_string(_file_id, _string); //JSON string
	
			file_text_close(_file_id);
	
			//confirmation message
			add_text_message("map saved successfully", 3, c_lime)
	
		} else add_text_message("save cancelled", 3, c_red)
		
	}
	
}

function load_map(file_name) {
	
	if (file_name != "") {
	
		//opening the file and reading values
		var _file_id = file_text_open_read(file_name);
		
		var _version = file_text_read_string(_file_id); //reading version number
		file_text_readln(_file_id);
	
		if (_version == save_system_version) { //checking if the file is valid
			
			var _grid_width = file_text_read_real(_file_id); //reading grid width
			file_text_readln(_file_id);
			var _grid_height = file_text_read_real(_file_id); //reading grid height
			file_text_readln(_file_id);
			var _marker_url = file_text_read_string(_file_id); //reading marker url
			file_text_readln(_file_id);
	
			var _json_string = file_text_readln(_file_id);
			file_text_close(_file_id)
		
			//converting the JSON string into an array
			_converted_array = json_parse(_json_string);
		
			//updating the grid and writing values
			if (global.grid_width != _grid_width || global.grid_height != _grid_height) { //resizing the grid if not the same size
				ds_grid_resize(global.tile_grid, _grid_width, _grid_height);
				global.grid_width = _grid_width;
				global.grid_height = _grid_height;
			}
		
			for (var i = 0; i < _grid_width; i++) {
				for (var j = 0; j < _grid_height; j++) {
				
					ds_grid_set(global.tile_grid, i, j, _converted_array[i, j]);
				
				}
			}
			
			//reloading the markers
			marker_url = _marker_url
			reload_markers();
		
			//confirmation message
			add_text_message("map loaded successfully", 3, c_lime)
		
		} 
		else {
		
			add_text_message("!!! the file is outdated !!!", 3, c_yellow)
		
		}
	
	} else add_text_message("load cancelled", 3, c_red)
	
}
	

function reload_markers() {
	checking_sprite = sprite_add(marker_url, 1, false, false, 0, 0);
}

function draw_marker_set(_x, _y) {
	
	for (var i = 0; i < tile_amount; i++) {
		
		if (selected_marker == i) {
			draw_nine_slice(spr_edge_nineslice, _x - 2, _y + 40 * i - (40 * tiles_per_page * tile_page) - 2, _x + 34, _y + 40 * i - (40 * tiles_per_page * tile_page) + 34);
		}
		
		draw_sprite(marker_sprite, i, _x, _y + 40 * i - (40 * tiles_per_page * tile_page))
		
	}
	
}

function get_selected_marker(_x, _y) {
	
	var _return = noone;
	
	for (var i = 0; i < obj_gameController.tile_amount; i++) {
		
		var _x1 = _x
		var _y1 = _y + 40 * i - (40 * obj_gameController.tiles_per_page * obj_gameController.tile_page)
		
		if (point_in_rectangle(global.mouse_pos_x, global.mouse_pos_y, _x1, _y1, _x1 + 32, _y1 + 32)) {
			_return = i;
		}
		
	}
	
	return(_return);
	
}