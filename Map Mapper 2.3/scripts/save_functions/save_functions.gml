function save_map(file_name){
	ini_open(file_name);
	ini_write_string("information","map_name",file_name);
	ini_write_string("map_grids","main_grid",ds_grid_write(global.mainGrid));
	ini_write_string("map_grids","subimg_grid",ds_grid_write(global.SubimgGrid));
	ini_write_string("map_grids","room_grid",ds_grid_write(global.RoomGrid));
	ini_write_string("map_grids","color_grid",ds_grid_write(global.ColorGrid));
	ini_write_string("map_grids","marker_grid",ds_grid_write(global.MarkerGrid));
	ini_write_string("map_grids","door_grid",ds_grid_write(global.DoorGrid));
	ini_close();
	
	var f = filename_name(file_name);
	selected_map = string_delete(f,string_length(f)-string_length(extension)+1,string_length(extension));
}

function load_map(file_name) {
	ini_open(file_name);
	ds_grid_read(global.mainGrid,ini_read_string("map_grids","main_grid",""));
	ds_grid_read(global.SubimgGrid,ini_read_string("map_grids","subimg_grid",""));
	ds_grid_read(global.RoomGrid,ini_read_string("map_grids","room_grid",""));
	ds_grid_read(global.ColorGrid,ini_read_string("map_grids","color_grid",""));
	ds_grid_read(global.MarkerGrid,ini_read_string("map_grids","marker_grid",""));
	ds_grid_read(global.DoorGrid,ini_read_string("map_grids","door_grid",""));
	ini_close();
	
	var f = filename_name(file_name);
	selected_map = string_delete(f,string_length(f)-string_length(extension)+1,string_length(extension));
	
	surface_free(door_surface);
}