function save_map(file_name){
	
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
	
		file_text_write_string(_file_id, global.version); //version number
		file_text_writeln(_file_id);
		file_text_write_real(_file_id, _grid_width); //grid width
		file_text_writeln(_file_id);
		file_text_write_real(_file_id, _grid_height); //grid height
		file_text_writeln(_file_id);
	
		file_text_write_string(_file_id, _string); //JSON string
	
		file_text_close(_file_id);
	
		//confirmation message
		add_text_message("map saved successfully", 3)
	
	} else add_text_message("save cancelled", 3)
	
}

function load_map(file_name) {
	
	if (file_name != "") {
	
		//opening the file and reading values
		var _file_id = file_text_open_read(file_name);
	
		var _version = file_text_read_string(_file_id); //reading version number
		file_text_readln(_file_id);
		var _grid_width = file_text_read_real(_file_id); //reading grid width
		file_text_readln(_file_id);
		var _grid_height = file_text_read_real(_file_id); //reading grid height
		file_text_readln(_file_id);
	
		var _json_string = file_text_readln(_file_id);
		file_text_close(_file_id)
	
		if (_version == global.version) { //checking if the file is valid
		
			//converting the JSON string into an array
			_converted_array = json_parse(_json_string);
		
			//updating the grid and writing values
			if !(global.grid_width == _grid_width || global.grid_height == _grid_height) { //resizing the grid if not the same size
				ds_grid_resize(global.tile_grid, _grid_width, _grid_height);
				global.grid_width = _grid_width;
				global.grid_height = _grid_height;
			}
		
			for (var i = 0; i < _grid_width; i++) {
				for (var j = 0; j < _grid_height; j++) {
				
					ds_grid_set(global.tile_grid, i, j, _converted_array[i, j]);
				
				}
			}
		
			//confirmation message
			add_text_message("map loaded successfully", 3)
		
		} 
		else {
		
			add_text_message("!!! the file is outdated !!!", 3)
		
		}
	
	} else add_text_message("load cancelled", 3)
	
}