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
		
		var pos_x = max(0 - global.cam_pos_x, 0);
		var pos_y = i * inc - global.cam_pos_y;
		
		draw_set_alpha(0.4);
		draw_line_width(pos_x , pos_y, min(w - global.cam_pos_x, global.view_width), pos_y, thickness);

	}


	for (var i = 0; i < w / inc + 1; i ++)	//vertical lines
	{
		
		var pos_x = i * inc - global.cam_pos_x;
		var pos_y = max(0 - global.cam_pos_y, 0);
		
		draw_set_alpha(0.4);
		draw_line_width(pos_x, pos_y, pos_x, min(h - global.cam_pos_y, global.view_height), thickness);
	}


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
	var max_y = min(global.grid_height,floor( min_y + ( cam_h / tile_size ) ) +2);
	
	
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
					draw_rectangle_color(pos_x, pos_y, pos_x + tile_size - 1, pos_y + tile_size - 1, col, col, col, col, false);
				
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
		
}
	
	
function clear_cell(cell_struct) { //clears a tile cell on the grid
	
		cell_struct.main = ID.empty;
		cell_struct.rm_nmb = 0;
		cell_struct.col = 0;
		cell_struct.subimg = 0;
		cell_struct.mrk = marker.empty;
		cell_struct.door = [[hatch.empty, 0],[hatch.empty, 90],[hatch.empty, 180],[hatch.empty, 270]]
	
}
	

function shift_grid_x(grid, amount) { //shifts a grid by amount cells in x direction
	var _grid_width = ds_grid_width(grid);
	var _grid_height = ds_grid_height(grid);
	ds_grid_set_grid_region(grid, grid, 0, 0, _grid_width - amount, _grid_height, amount, 0);
	ds_grid_set_region(grid, 0, 0, amount, _grid_height, 0);
}

function shift_grid_y(grid, amount) { //shifts a grid by amount cells in x direction
	var _grid_width = ds_grid_width(grid);
	var _grid_height = ds_grid_height(grid);
	ds_grid_set_grid_region(grid, grid, 0, 0, _grid_width, _grid_height - amount, 0, amount);
	ds_grid_set_region(grid, 0, 0, _grid_width, amount, 0);
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