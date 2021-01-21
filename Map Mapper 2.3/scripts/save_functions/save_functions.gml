function save_map(file_name){
	ini_open(file_name);
	ini_write_string("information","map_name",file_name);
	
	
	ini_close();
	
	var f = filename_name(file_name);
	selected_map = string_delete(f,string_length(f)-string_length(extension)+1,string_length(extension));
}

function load_map(file_name) {
	ini_open(file_name);
	
	ini_close();
	
	var f = filename_name(file_name);
	selected_map = string_delete(f,string_length(f)-string_length(extension)+1,string_length(extension));
	
	surface_free(door_surface);
}