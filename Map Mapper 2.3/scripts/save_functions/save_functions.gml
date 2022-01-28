function check_valid_dir(file_name) { //checks if the file location is valid and returns true if valid
	
	//checking if the directory is valid
	var wd_length = string_length(working_directory);
	var directory_length = string_length(file_name);
	var excess_length = max(directory_length - wd_length, 0);
	
	var check_directory = string_delete(file_name, wd_length + 1, excess_length);
	if (check_directory == working_directory) { //gamemaker doesnt allow for saving in working directory
		add_text_message("The program directory is an invalid location!", 4, c_red);
		return(false);
	}
	
	//pressed cancel in file select
	if (file_name == "") {
		add_text_message("save cancelled", 3, c_red);
		return(false);
	}
	
	return(true); //no problems found
}

function save_map(file_name) { //saves the map in a file

	if (check_valid_dir(file_name)) {
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
	}
	
}

function load_map(file_name) { //loads a map from a file
	
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
	
function convert_map_smart() { //returns a grid with SMART compatible values
	//converts all map tiles to be smart compatible
	var new_grid = ds_grid_create(global.grid_width, global.grid_height);
	
	for (var i = 0; i < global.grid_width; i++) {
		for (var j = 0; j < global.grid_height; j++) {
			
			var _tile = ds_grid_get(global.tile_grid, i, j); //gets current tile object in loop
			
			//converting tile_id for SMART
			if (_tile.main == 0) check_list = "empty"
			else {
				if (_tile.mrk != marker.empty) { //SM only has dots so every marker will be a dot
					_tile.mrk = 1
				}
				else _tile.mrk = 0
				
				//list with Mapper SubimageID and if it has a marker or not
				var check_list = [_tile.subimg, _tile.mrk];
			}
			
			//converting tile_id for SMART
			//comparing with Super Metroid TileIDs (nowhere near everything is supported)
			var TILE_ID
			//switch (check_list) {	   //"ID", H, V
			//	//TILE LIBRARY (IF YOU WANT TO CHANGE THIS, USE THE SUPER METROID EDITOR SMART
			//	//TO GET PROPER TILEID'S
			//	case "empty": TILE_ID = ["1E", 0, 0]; break;
			//	
			//	case [0, 0]: TILE_ID = ["20", 0, 0]; break;
			//	case [0, 1]: TILE_ID = ["6F", 0, 0]; break;
			//	
			//	case [1, 0]: TILE_ID = ["24", 0, 1]; break;
			//	case [1, 1]: TILE_ID = ["6E", 0, 1]; break;
			//	
			//	case [2, 0]: TILE_ID = ["24", 0, 0]; break;
			//	case [2, 1]: TILE_ID = ["6E", 0, 0]; break;
			//	
			//	case [3, 0]: TILE_ID = ["23", 0, 0]; break;
			//	
			//	case [4, 0]: TILE_ID = ["21", 1, 0]; break;
			//	case [4, 1]: TILE_ID = ["8F", 1, 0]; break;
			//	
			//	case [5, 0]: TILE_ID = ["25", 1, 1]; break;
			//	case [5, 1]: TILE_ID = ["8E", 1, 1]; break;
			//	
			//	case [6, 0]: TILE_ID = ["25", 1, 0]; break;
			//	case [6, 1]: TILE_ID = ["8E", 1, 0]; break;
			//	
			//	case [7, 0]: TILE_ID = ["27", 0, 0]; break;
			//	case [7, 1]: TILE_ID = ["77", 1, 0]; break;
			//	
			//	case [8, 0]: TILE_ID = ["21", 0, 0]; break;
			//	case [8, 1]: TILE_ID = ["8F", 0, 0]; break;
			//	
			//	case [9, 0]: TILE_ID = ["25", 0, 1]; break;
			//	case [9, 1]: TILE_ID = ["8E", 0, 1]; break;
			//	
			//	case [10, 0]: TILE_ID = ["25", 0, 0]; break;
			//	case [10, 1]: TILE_ID = ["8E", 0, 0]; break;
			//	
			//	case [11, 0]: TILE_ID = ["27", 1, 0]; break;
			//	case [11, 1]: TILE_ID = ["77", 0, 0]; break;
			//	
			//	case [12, 0]: TILE_ID = ["22", 0, 0]; break;
			//	case [12, 1]: TILE_ID = ["5E", 0, 0]; break;
			//	
			//	case [13, 0]: TILE_ID = ["26", 0, 1]; break;
			//	
			//	case [14, 0]: TILE_ID = ["26", 0, 0]; break;
			//	
			//	case [15, 0]: TILE_ID = ["1B", 0, 0]; break;
			//	
			//	default: TILE_ID = ["1E", 0, 0]; break;
			//}
			
			//saving new tile
			ds_grid_add(new_grid, i, j, TILE_ID);
		}
	}
	
	return (new_grid);
}
	
function save_map_smart(file_name) {
	
}