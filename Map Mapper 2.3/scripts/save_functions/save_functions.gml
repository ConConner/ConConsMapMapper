function check_valid_dir(file_name, action = "") { //checks if the file location is valid and returns true if valid
	
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
		add_text_message(action + " cancelled", 3, c_red);
		return(false);
	}
	
	return(true); //no problems found
}

function save_map(file_name) { //saves the map in a file

	if (check_valid_dir(file_name, "save")) {
		//converting grid into array
		var _grid_width = global.grid_width;
		var _grid_height = global.grid_height;
		_converted_array[global.grid_width,global.grid_height] = 0;
	
		for (var i = 0; i < _grid_width; i++) {
			for (var j = 0; j < _grid_height; j++) {
				
				var _tile = ds_grid_get(global.tile_grid, i, j);
				if (_tile.main || _tile.mrk != marker.empty) _converted_array[i, j] = ds_grid_get(global.tile_grid, i, j);
				else _converted_array[i, j] = 0;
			}
		}
	
		//converting the array to JSON string and writing it into a file
		var _string = json_stringify(_converted_array);
		var _file_id = file_text_open_write(file_name);
	
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
		add_text_message("map saved successfully", 3, c_lime);
		
		//changing global map directory
		global.map_dir = file_name;
	}
	
}

function load_map(file_name) { //loads a map from a file; Returns true if successful
	
	if (check_valid_dir(file_name, "load")) {
	
		//opening the file and reading values
		var _file_id = file_text_open_read(file_name);
		
		var _version = file_text_read_string(_file_id); //reading version number
		file_text_readln(_file_id);
		
		if (_version != save_system_version && _version != "1.0") {	//checking if the file is valid
			add_text_message("MapMapper is outdated!", 3, c_red);
			return (false);
		}
			
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
			
		var _room_count = 0; //while looping through grid, searching for highest room number
		for (var i = 0; i < _grid_width; i++) {
			for (var j = 0; j < _grid_height; j++) {
				
				if (_converted_array[i, j] != 0) {
					
					if (_version == "1.0") _converted_array[i, j].mrk_c = c_white;
					
					ds_grid_set(global.tile_grid, i, j, _converted_array[i, j]);
					_room_count = max(_room_count, _converted_array[i, j].rm_nmb);
				}
					
			}
		}
		set_up_grid(); //filling in the empty tiles
		
		global.roomCount = _room_count;
		old_roomCount = _room_count;
			
		//reloading the markers
		marker_url = _marker_url
		reload_markers();
		
		//confirmation message
		add_text_message("map loaded successfully", 3, c_lime);
			
		//changing global map directory
		global.map_dir = file_name;
		return (true);
	}
	return (false);
}
	
function convert_map_smart() { //returns a grid with SMART compatible values
	//converts all map tiles to be smart compatible
	var new_grid = ds_grid_create(global.grid_width, global.grid_height);
	
	for (var i = 0; i < global.grid_width; i++) {
		for (var j = 0; j < global.grid_height; j++) {
			
			var _tile = ds_grid_get(global.tile_grid, i, j); //gets current tile object in loop
			var check_list = [0, 0]; //list with Mapper SubimageID and if it has a marker or not		
			
			//converting tile_id for SMART
			if (_tile.main == 0) check_list = "empty"
			else {
				if (_tile.mrk != marker.empty) check_list[1] = 1; //SM only has dots so every marker will be a dot
				check_list[0] = _tile.subimg;
				show_debug_message(check_list);
			}
			
			//converting tile_id for SMART
			//comparing with Super Metroid TileIDs (nowhere near everything is supported)
				//TILE LIBRARY (IF YOU WANT TO CHANGE THIS, USE THE SUPER METROID EDITOR SMART
				//TO GET PROPER TILEID'S
			var TILE_ID = ["1E", 0, 0]
												//"ID", H, V
			if (check_list == "empty") TILE_ID = ["1F", 0, 0];
			
			else {
				if (array_equals(check_list, [0, 0])) TILE_ID = ["20", 0, 0];
				if (array_equals(check_list, [0, 1])) TILE_ID = ["6F", 0, 0];
										
				if (array_equals(check_list, [1, 0])) TILE_ID = ["24", 0, 1];
				if (array_equals(check_list, [1, 1])) TILE_ID = ["6E", 0, 1];
		
				if (array_equals(check_list, [2, 0])) TILE_ID = ["24", 0, 0];
				if (array_equals(check_list, [2, 1])) TILE_ID = ["6E", 0, 0];
		
				if (array_equals(check_list, [3, 0])) TILE_ID = ["23", 0, 0];
		
				if (array_equals(check_list, [4, 0])) TILE_ID = ["21", 1, 0];
				if (array_equals(check_list, [4, 1])) TILE_ID = ["8F", 1, 0];

				if (array_equals(check_list, [5, 0])) TILE_ID = ["25", 1, 1];
				if (array_equals(check_list, [5, 1])) TILE_ID = ["8E", 1, 1];

				if (array_equals(check_list, [6, 0])) TILE_ID = ["25", 1, 0];
				if (array_equals(check_list, [6, 1])) TILE_ID = ["8E", 1, 0];

				if (array_equals(check_list, [7, 0])) TILE_ID = ["27", 0, 0];
				if (array_equals(check_list, [7, 1])) TILE_ID = ["77", 1, 0];

				if (array_equals(check_list, [8, 0])) TILE_ID = ["21", 0, 0];
				if (array_equals(check_list, [8, 1])) TILE_ID = ["8F", 0, 0];

				if (array_equals(check_list, [9, 0])) TILE_ID = ["25", 0, 1];
				if (array_equals(check_list, [9, 1])) TILE_ID = ["8E", 0, 1];
 
				if (array_equals(check_list, [10, 0])) TILE_ID = ["25", 0, 0];
				if (array_equals(check_list, [10, 1])) TILE_ID = ["8E", 0, 0];
										 
				if (array_equals(check_list, [11, 0])) TILE_ID = ["27", 1, 0];
				if (array_equals(check_list, [11, 1])) TILE_ID = ["77", 0, 0];
										 
				if (array_equals(check_list, [12, 0])) TILE_ID = ["22", 0, 0];
				if (array_equals(check_list, [12, 1])) TILE_ID = ["5E", 0, 0];
										 
				if (array_equals(check_list, [13, 0])) TILE_ID = ["26", 0, 1];
										 
				if (array_equals(check_list, [14, 0])) TILE_ID = ["26", 0, 0];
										 
				if (array_equals(check_list, [15, 0])) TILE_ID = ["1B", 0, 0];
			}
			
			//saving new tile
			ds_grid_set(new_grid, i, j, TILE_ID);
		}
	}
	//resizing grid to fit in 64x32
	ds_grid_resize(new_grid, 64, 32);
	
	return (new_grid);
}
	
function save_map_smart(file_name) { //saves a .xml file which can be directly imported into SMART
	
	if (check_valid_dir(file_name, "SMART export")) {
		
		//creating the xml file
		var _file = file_text_open_write(file_name);
		
		//writing Data
		file_text_write_string(_file, "<Map>");
		file_text_writeln(_file);
		file_text_write_string(_file, "<TileData>");
		file_text_writeln(_file);
			
		//Tile data is going here
		//The Tile Data is split up into 2 32x32 tile chunks so the grid needs to be split
		//each Tile is 2 bytes and each line holds 32 bytes (16 tiles)
		var smart_map = convert_map_smart();
		var counter = 0;
			
		for (var chunk = 0; chunk < 2; chunk++;) { //saying which chunk it is
			for (var j = 0; j < 32; j++;) { //looping left to right
				for (var i = 0; i < 32; i++;) {
						
					var _tile = ds_grid_get(smart_map, i + (chunk * 32), j);
					if (_tile = 0) _tile = ["1F", 0, 0]; //default tile if resized grid has 0 in it
					var _bytes = 0;
					
					_bytes = _bytes ^ hex_to_dec(_tile[0]) //setting TILE ID
					if (_tile[1] == 1) _bytes = _bytes ^ 16384 //horizontal flip
					if (_tile[2] == 1) _bytes = _bytes ^ 32768 //vertical flip
					_bytes = _bytes ^ 3072 //palette and priority bit
						
					//writing data
					file_text_write_string(_file, dec_to_hex(_bytes) + " ");
					counter++;
					if (counter == 16) {  //every 16 bytes there should be a line break
						file_text_writeln(_file);
						counter = 0;
					}
				}
			}
		}
			
		file_text_write_string(_file, "</TileData>");
		file_text_writeln(_file);
		file_text_write_string(_file, "</Map>");
		file_text_writeln(_file);
		
		//closing
		file_text_close(_file);
		
		add_text_message("map exported successfully", 3, c_lime);
	}
}
	
function save_settings() {
	
	ini_open("MapMapper.settings");
	
	ini_write_real("general", "tooltips", show_tooltips);
	ini_write_real("general", "cursor", show_cursor);
	ini_write_real("map_settings", "grid_visibility", show_grid);
	ini_write_real("window", "width", global.window_width);
	ini_write_real("window", "heigth", global.window_height);
	
	ini_close();
}

function load_settings() {
	
	ini_open("MapMapper.settings");
	
	//setting values
	show_tooltips = ini_read_real("general", "tooltips", show_tooltips);
	show_grid = ini_read_real("map_settings", "grid_visibility", show_grid);
	show_cursor = ini_read_real("general", "cursor", show_cursor);
	global.window_width = ini_read_real("window", "width", global.window_width);
	global.window_height = ini_read_real("window", "height", global.window_height);
	
	ini_close();
}