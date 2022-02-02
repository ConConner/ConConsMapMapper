//tile grid functions
function set_up_grid() { //this loops through the tile grid and refills every 0 with an empty tile. Use this after resizing the grid.
	for (var i = 0; i < global.grid_width; i++) {
		
		for (var j = 0; j < global.grid_height; j++) {
			
			if (ds_grid_get(global.tile_grid, i, j) == 0) {
				
				ds_grid_set(global.tile_grid, i, j, new tile_info(ID.empty,0,0,0,marker.empty,[[hatch.empty, 0],[hatch.empty, 90],[hatch.empty, 180],[hatch.empty, 270]]));
				
			}
			
		}
	}
}


function draw_grid(w, h, thickness, inc) { //draws the visual grid_background
	
	for (var i = 0; i < h / inc + 1; i ++)	//horizontal lines
	{
		
		var pos_x = -global.cam_pos_x;
		var pos_y = i * inc - global.cam_pos_y;
		
		draw_line_width(pos_x , pos_y, min(w - global.cam_pos_x, global.view_width), pos_y, thickness);

	}


	for (var i = 0; i < w / inc + 1; i ++)	//vertical lines
	{
		
		var pos_x = i * inc - global.cam_pos_x;
		var pos_y = - global.cam_pos_y;
		
		draw_line_width(pos_x, pos_y, pos_x, min(h - global.cam_pos_y, global.view_height), thickness);
	}


}

function draw_grid_whole(w, h, thickness, inc) { //draws the visual grid_background all at once (even if not in view)
	
	for (var i = 0; i < h / inc + 1; i ++)	//horizontal lines
	{
		
		var pos_x = 0;
		var pos_y = i * inc;
		
		draw_line_width(pos_x , pos_y, w, pos_y, thickness);

	}


	for (var i = 0; i < w / inc + 1; i ++)	//vertical lines
	{
		
		var pos_x = i * inc;
		var pos_y = 0;
		
		draw_line_width(pos_x, pos_y, pos_x, h, thickness);
	}


}

function draw_grid_outline(w, h, thickness) { //draws only the outline of the grid
	
	var top = - global.cam_pos_y;
	var left = - global.cam_pos_x;
	
	draw_line_width(left, top, left + w, top, thickness);
	draw_line_width(left, top, left, top + h, thickness);
	draw_line_width(left + w, top, left + w, top + h, thickness);
	draw_line_width(left, top + h, left + w, top + h, thickness);
	
}


function load_grid() { //draws the contents on the grid
	
	//getting camera position
	var cam_x = global.cam_pos_x;
	var cam_y = global.cam_pos_y;
	var cam_w = global.view_width;
	var cam_h = global.view_height;
	var min_x = max(0,floor( cam_x / tile_size ) -1);
	var min_y = max(0,floor( cam_y / tile_size ) -1);
	var max_x = min(global.grid_width,floor( min_x + ( cam_w / tile_size ) ) +2);
	var max_y = min(global.grid_height,ceil( min_y + ( cam_h / tile_size ) ) +2);
	
	//hammer tile edge buffer
	var _hammer_tiles = ds_list_create();
	
	//looping through the grid and drawing tiles
	for (var draw_x = min_x; draw_x < max_x; draw_x++) {
	
		for (var draw_y = min_y; draw_y < max_y; draw_y++) {
			
			var pos_x = draw_x * tile_size - global.cam_pos_x;
			var pos_y = draw_y * tile_size - global.cam_pos_y;
			
			var tile = ds_grid_get(global.tile_grid, draw_x, draw_y);
			if (tile != 0) {
				var col = tile.col
			
				// normal tile drawing
				if (tile.main == ID.filled) { 
				
					//drawing the inside of the tile
					if (tile.subimg < 16) draw_rectangle_color(pos_x, pos_y, pos_x + tile_size - 1, pos_y + tile_size - 1, col, col, col, col, false);
					else {
						switch (tile.subimg) { //drawing inside of hammered tiles
							case (16): {
								draw_triangle_color(pos_x, pos_y + tile_size - 1, pos_x + tile_size - 1, pos_y + tile_size - 1, pos_x + tile_size - 1, pos_y, col, col, col, false);
								break; }
								
							case (17): {
								draw_triangle_color(pos_x - 1, pos_y, pos_x - 1, pos_y + tile_size - 1, pos_x + tile_size - 1, pos_y + tile_size - 1, col, col, col, false);
								break; }
								
							case (18): {
								draw_triangle_color(pos_x - 1, pos_y - 1, pos_x - 1, pos_y + tile_size - 1, pos_x + tile_size - 1, pos_y - 1, col, col, col, false);
								break; }
								
							case (19): {
								draw_triangle_color(pos_x, pos_y - 1, pos_x + tile_size - 1, pos_y + tile_size - 1, pos_x + tile_size - 1, pos_y - 1, col, col, col, false);
								break;}
								
							case (20): {
								draw_rectangle_color(pos_x, pos_y + 11, pos_x + tile_size - 1, pos_y + 19, col, col, col, col, false);
								
								//drawing edges if no more tunnel tiles
								var tile_left = ds_grid_get(global.tile_grid, draw_x - 1, draw_y);
								var tile_right = ds_grid_get(global.tile_grid, draw_x + 1, draw_y);
								if (tile_left.subimg != 20) draw_sprite(spr_mapTiles, 22, pos_x - 2, pos_y);
								if (tile_right.subimg != 20) ds_list_add(_hammer_tiles, [22, pos_x + tile_size, pos_y]);
								
								break; }
								
							case (21): {
								draw_rectangle_color(pos_x + 11, pos_y, pos_x + 19, pos_y + tile_size - 1, col, col, col, col, false);
								
								//drawing edges if no more tunnel tiles
								var tile_up = ds_grid_get(global.tile_grid, draw_x, draw_y - 1);
								var tile_down = ds_grid_get(global.tile_grid, draw_x, draw_y + 1);
								if (tile_up.subimg != 21) draw_sprite(spr_mapTiles, 23, pos_x, pos_y - 2);
								if (tile_down.subimg != 21) ds_list_add(_hammer_tiles, [23, pos_x, pos_y + tile_size]);
								
								break; }
						}
					}
				
					//drawing outline
					draw_sprite(spr_mapTiles, tile.subimg, pos_x, pos_y);
				}
				
			
				#region door drawing
				if (tile.door[0,0] == hatch.filled) {
					draw_sprite_ext(spr_doorTiles, 0, pos_x, pos_y, 1, 1, 0, c_white, 1) //up
					var _col = tile.door[0,1];
					draw_rectangle_color(pos_x + 12, pos_y, pos_x + 19, pos_y + 3, _col, _col, _col, _col, false);
				}
			
				if (tile.door[1,0] == hatch.filled) {
					draw_sprite_ext(spr_doorTiles, 1, pos_x, pos_y, 1, 1, 0, c_white, 1) //right
					var _col = tile.door[1,1];
					draw_rectangle_color(pos_x + 28, pos_y + 12, pos_x + 31, pos_y + 19, _col, _col, _col, _col, false);
				}
			
				if (tile.door[2,0] == hatch.filled) {
					draw_sprite_ext(spr_doorTiles, 2, pos_x, pos_y, 1, 1, 0, c_white, 1) //down
					var _col = tile.door[2,1];
					draw_rectangle_color(pos_x + 12, pos_y + 28, pos_x + 19, pos_y + 31, _col, _col, _col, _col, false);
				}
			
				if (tile.door[3,0] == hatch.filled) {
					draw_sprite_ext(spr_doorTiles, 3, pos_x, pos_y, 1, 1, 0, c_white, 1) //left
					var _col = tile.door[3,1];
					draw_rectangle_color(pos_x, pos_y + 12, pos_x + 3, pos_y + 19, _col, _col, _col, _col, false);
				}
				#endregion
			
				#region marker drawing
				if (tile.mrk != marker.empty && sprite_exists(marker_sprite)) {
					draw_sprite(marker_sprite, tile.mrk, pos_x, pos_y);
				}
				#endregion
			}
		}
	}
	//adding missing hammer edges
	for (var i = 0; i < ds_list_size(_hammer_tiles); i++) {
		var _hammer_edge = ds_list_find_value(_hammer_tiles, i);
		draw_sprite(spr_mapTiles, _hammer_edge[0], _hammer_edge[1], _hammer_edge[2]);
	}
	
	ds_list_destroy(_hammer_tiles);
		
}

function load_grid_whole() { //draws the contents on the grid all at once (even if not in view)
	
	//hammer tile edge buffer
	var _hammer_tiles = ds_list_create();
	
	//looping through the grid and drawing tiles
	for (var draw_x = 0; draw_x < global.grid_width; draw_x++) {
	
		for (var draw_y = 0; draw_y < global.grid_height; draw_y++) {
			
			var pos_x = draw_x * tile_size;
			var pos_y = draw_y * tile_size;
			
			var tile = ds_grid_get(global.tile_grid, draw_x, draw_y);
			if (tile != 0) {
				var col = tile.col
			
				// normal tile drawing
				if (tile.main == ID.filled) { 
				
					//drawing the inside of the tile
					if (tile.subimg < 16) draw_rectangle_color(pos_x, pos_y, pos_x + tile_size - 1, pos_y + tile_size - 1, col, col, col, col, false);
					else {
						switch (tile.subimg) { //drawing inside of hammered tiles
							case (16): {
								draw_triangle_color(pos_x, pos_y + tile_size - 1, pos_x + tile_size - 1, pos_y + tile_size - 1, pos_x + tile_size - 1, pos_y, col, col, col, false);
								break; }
								
							case (17): {
								draw_triangle_color(pos_x - 1, pos_y, pos_x - 1, pos_y + tile_size - 1, pos_x + tile_size - 1, pos_y + tile_size - 1, col, col, col, false);
								break; }
								
							case (18): {
								draw_triangle_color(pos_x - 1, pos_y - 1, pos_x - 1, pos_y + tile_size - 1, pos_x + tile_size - 1, pos_y - 1, col, col, col, false);
								break; }
								
							case (19): {
								draw_triangle_color(pos_x, pos_y - 1, pos_x + tile_size - 1, pos_y + tile_size - 1, pos_x + tile_size - 1, pos_y - 1, col, col, col, false);
								break;}
								
							case (20): {
								draw_rectangle_color(pos_x, pos_y + 11, pos_x + tile_size - 1, pos_y + 19, col, col, col, col, false);
								
								//drawing edges if no more tunnel tiles
								var tile_left = ds_grid_get(global.tile_grid, draw_x - 1, draw_y);
								var tile_right = ds_grid_get(global.tile_grid, draw_x + 1, draw_y);
								if (tile_left.subimg != 20) draw_sprite(spr_mapTiles, 22, pos_x - 2, pos_y);
								if (tile_right.subimg != 20) ds_list_add(_hammer_tiles, [22, pos_x + tile_size, pos_y]);
								
								break; }
								
							case (21): {
								draw_rectangle_color(pos_x + 11, pos_y, pos_x + 19, pos_y + tile_size - 1, col, col, col, col, false);
								
								//drawing edges if no more tunnel tiles
								var tile_up = ds_grid_get(global.tile_grid, draw_x, draw_y - 1);
								var tile_down = ds_grid_get(global.tile_grid, draw_x, draw_y + 1);
								if (tile_up.subimg != 21) draw_sprite(spr_mapTiles, 23, pos_x, pos_y - 2);
								if (tile_down.subimg != 21) ds_list_add(_hammer_tiles, [23, pos_x, pos_y + tile_size]);
								
								break; }
						}
					}
				
					//drawing outline
					draw_sprite(spr_mapTiles, tile.subimg, pos_x, pos_y);
				}
				
			
				#region door drawing
				if (tile.door[0,0] == hatch.filled) {
					draw_sprite_ext(spr_doorTiles, 0, pos_x, pos_y, 1, 1, 0, c_white, 1) //up
					var _col = tile.door[0,1];
					draw_rectangle_color(pos_x + 12, pos_y, pos_x + 19, pos_y + 3, _col, _col, _col, _col, false);
				}
			
				if (tile.door[1,0] == hatch.filled) {
					draw_sprite_ext(spr_doorTiles, 1, pos_x, pos_y, 1, 1, 0, c_white, 1) //right
					var _col = tile.door[1,1];
					draw_rectangle_color(pos_x + 28, pos_y + 12, pos_x + 31, pos_y + 19, _col, _col, _col, _col, false);
				}
			
				if (tile.door[2,0] == hatch.filled) {
					draw_sprite_ext(spr_doorTiles, 2, pos_x, pos_y, 1, 1, 0, c_white, 1) //down
					var _col = tile.door[2,1];
					draw_rectangle_color(pos_x + 12, pos_y + 28, pos_x + 19, pos_y + 31, _col, _col, _col, _col, false);
				}
			
				if (tile.door[3,0] == hatch.filled) {
					draw_sprite_ext(spr_doorTiles, 3, pos_x, pos_y, 1, 1, 0, c_white, 1) //left
					var _col = tile.door[3,1];
					draw_rectangle_color(pos_x, pos_y + 12, pos_x + 3, pos_y + 19, _col, _col, _col, _col, false);
				}
				#endregion
			
				#region marker drawing
				if (tile.mrk != marker.empty && sprite_exists(marker_sprite)) {
					draw_sprite(marker_sprite, tile.mrk, pos_x, pos_y);
				}
				#endregion
			}
		}
	}
	//adding missing hammer edges
	for (var i = 0; i < ds_list_size(_hammer_tiles); i++) {
		var _hammer_edge = ds_list_find_value(_hammer_tiles, i);
		draw_sprite(spr_mapTiles, _hammer_edge[0], _hammer_edge[1], _hammer_edge[2]);
	}
	
	ds_list_destroy(_hammer_tiles);	
}

	
function clear_cell(cell_struct) { //clears a tile cell on the grid
	
		cell_struct.main = ID.empty;
		cell_struct.rm_nmb = 0;
		cell_struct.col = 0;
		cell_struct.subimg = 0;
		cell_struct.mrk = marker.empty;
		cell_struct.door = [[hatch.empty, 0],[hatch.empty, 90],[hatch.empty, 180],[hatch.empty, 270]]
	
}
	

function shift_grid_x_pos(grid) { //shifts a grid cell in x direction
	var _grid_width = ds_grid_width(grid);
	var _grid_height = ds_grid_height(grid);
	ds_grid_set_grid_region(grid, grid, 0, 0, _grid_width - 1, _grid_height, 1, 0);
	ds_grid_set_region(grid, 0, 0, 0, _grid_height, 0);
}

function shift_grid_y_pos(grid) { //shifts a grid cell in y direction
	var _grid_width = ds_grid_width(grid);
	var _grid_height = ds_grid_height(grid);
	ds_grid_set_grid_region(grid, grid, 0, 0, _grid_width, _grid_height - 1, 0, 1);
	ds_grid_set_region(grid, 0, 0, _grid_width, 0, 0);
}
	
function shift_grid_x_neg(grid) { //shifts a grid cell in negative x direction
	var _grid_width = ds_grid_width(grid);
	var _grid_height = ds_grid_height(grid);
	ds_grid_set_grid_region(grid, grid, 1, 0, _grid_width, _grid_height, 0, 0);
}

function shift_grid_y_neg(grid) { //shifts a grid cell in negative y direction
	var _grid_width = ds_grid_width(grid);
	var _grid_height = ds_grid_height(grid);
	ds_grid_set_grid_region(grid, grid, 0, 1, _grid_width, _grid_height, 0, 0);
}


//text messages
function add_text_message(msg, lifetime, col) { //adds a new text message to the list
	
	grid_shift_x_up(global.text_grid);
	
	//setting the new text
	//message
	ds_grid_set(global.text_grid, 0, text.messg, msg);
	//lifetime
	ds_grid_set(global.text_grid, 0, text.life, lifetime);
	//alpha
	ds_grid_set(global.text_grid, 0, text.alph, 1);
	//color
	ds_grid_set(global.text_grid, 0, text.col, col);
	
}


function grid_shift_x_up(grid) { //shifting the messages up
	
	var grid_length = ds_grid_width(grid)
	for (var i = 0; i < grid_length; i++) {
		
		//getting variables
		var pos = (i - grid_length) * -1 - 1;
		var m = ds_grid_get(grid, pos, text.messg);
		var _lifetime = ds_grid_get(grid, pos, text.life);
		var _alpha = ds_grid_get(grid, pos, text.alph);
		var _color = ds_grid_get(grid, pos, text.col);
		
		if (m != 0) {
			
			//checking if grid is long enough for shift
			if (pos = grid_length) {
				ds_grid_resize(grid, grid_length + 1, 4)
			}
			
			//shifting the value one position up
			ds_grid_set(grid, pos + 1, text.messg, m);
			ds_grid_set(grid, pos + 1, text.life, _lifetime);
			ds_grid_set(grid, pos + 1, text.alph, _alpha);
			ds_grid_set(grid, pos + 1, text.col, _color);
			
			//deleting the old value
			ds_grid_set(grid, pos, text.messg, 0);
			ds_grid_set(grid, pos, text.life, 0);
			ds_grid_set(grid, pos, text.alph, 0);
			ds_grid_set(grid, pos, text.col, 0);
			
		}
		
	}
	
}
	
	
function update_text_message(_x, _y) { //updates the text messages
	
	draw_set_halign(fa_right);
	
	var grid = global.text_grid;
	var grid_length = ds_grid_width(grid);
	var spacing = 22;
	
	for (var i = 0; i < grid_length; i++) {
		
		var m = ds_grid_get(grid, i, text.messg);
		var _lifetime = ds_grid_get(grid, i, text.life);
		var _alpha = ds_grid_get(grid, i, text.alph);
		var _color = ds_grid_get(grid, i, text.col);
		
		//drawing the text
		if (m != 0) {
			draw_text_color(_x, _y - i * spacing, m, _color, _color, _color, _color, _alpha);
		}
		
		//updating the vars
		if (_lifetime <= 1) {
			ds_grid_set(grid, i, text.alph, _lifetime);
		}
		
		ds_grid_set(grid, i, text.life, _lifetime -0.01);
		
		if (_lifetime <= 0) {
			ds_grid_set(grid, i, text.messg, 0);
			ds_grid_set(grid, i, text.life, 0);
			ds_grid_set(grid, i, text.alph, 0);
		}
		
	}
	
	draw_set_halign(fa_left);
	
}
	
	
function setup_tool_tips() {
	
	pen_tool_tip[0] = "The pen allows you to add and remove";
	pen_tool_tip[1] = "map tiles.";
	pen_tool_tip[2] = "";
	pen_tool_tip[3] = "Left click on an empty tile to add a";
	pen_tool_tip[4] = "map tile. Right click on an existing";
	pen_tool_tip[5] = "map tile to remove it and all the";
	pen_tool_tip[6] = "contents on it.";
	pen_tool_tip[7] = "Left click and drag off of an exiting";
	pen_tool_tip[8] = "map tile to edit an already completed";
	pen_tool_tip[9] = "room.";
	
	color_picker_tool_tip[0] = "The color picker selects the color you";
	color_picker_tool_tip[1] = "are hovering over with the mouse.";
	color_picker_tool_tip[2] = "";
	color_picker_tool_tip[3] = "Left click anywhere on the grid to select";
	color_picker_tool_tip[4] = "the color you are hovering over as your";
	color_picker_tool_tip[5] = "usable color. The pen tool will be auto";
	color_picker_tool_tip[6] = "selected after selecting a color.";
	
	color_brush_tool_tip[0] = "The color brush allows you to change the";
	color_brush_tool_tip[1] = "color of an existing room or replace an";
	color_brush_tool_tip[2] = "existing color with a new one.";
	color_brush_tool_tip[3] = "";
	color_brush_tool_tip[4] = "Left click on a room to replace the color";
	color_brush_tool_tip[5] = "of it with your currently selected color.";
	color_brush_tool_tip[6] = "Right click on a tile with a color to";
	color_brush_tool_tip[7] = "replace every tile with the same color with";
	color_brush_tool_tip[8] = "your currently selected color.";
	
	door_tool_tip[0] = "The connection tool can create a connection";
	door_tool_tip[1] = "between two disconnected rooms. However, it";
	door_tool_tip[2] = "can also create a connection inside of a room.";
	door_tool_tip[3] = "";
	door_tool_tip[4] = "Left click and drag over two tiles to create";
	door_tool_tip[5] = "a connection between these two tiles. The";
	door_tool_tip[6] = "connection color will be your currently selected";
	door_tool_tip[7] = "color. Right click and drag over two tiles to";
	door_tool_tip[8] = "remove an existing connection between them.";
	door_tool_tip[9] = "If unsure, the cursor will always show possible";
	door_tool_tip[10] = "locations for connections.";
	
	marker_tool_tip[0] = "The marker tool allows you to place down one";
	marker_tool_tip[1] = "marker per cell on the grid. It does not have";
	marker_tool_tip[2] = "to have a map tile below it!";
	marker_tool_tip[3] = "";
	marker_tool_tip[4] = "Select a marker in the marker set on the right";
	marker_tool_tip[5] = "of the screen and place it on any grid cell";
	marker_tool_tip[6] = "with a left click. A right click will delete";
	marker_tool_tip[7] = "a marker from a grid cell.";
	
	hammer_tool_tip[0] = "The hammer tool allows you to change the";
	hammer_tool_tip[1] = "appearence of specific map tiles. You can";
	hammer_tool_tip[2] = "make sloped tiles or tunnel tiles.";
	hammer_tool_tip[3] = "";
	hammer_tool_tip[4] = "Left click on a normal tile to change it's";
	hammer_tool_tip[5] = "appearence. Left click on a changed tile to";
	hammer_tool_tip[6] = "reverse the process.";
	
	selection_tool_tip[0] = "U N F I N I S H E D!";
}