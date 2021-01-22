function set_up_grid() {
	for (var i = 0; i < global.grid_width; i++) {
		
		for (var j = 0; j < global.grid_height; j++) {
			
			if (ds_grid_get(global.tile_grid, i, j) == 0) {
				
				ds_grid_set(global.tile_grid, i, j, new tile_info(ID.empty,0,0,0,marker.empty,[[hatch.empty, 0],[hatch.empty, 90],[hatch.empty, 180],[hatch.empty, 270]]));
				
			}
			
		}
	}
}


function draw_grid(w,inc) {
	
	for (var i = 0; i < room_height/inc+1; i += 1)
	{
		if ((i % 25) == 0) draw_set_alpha(0.8);
		else draw_set_alpha(0.4);
		draw_line_width(0,i*inc,room_width,i*inc,w);

	}


	for (var i = 0; i < room_width/inc+1; i += 1)
	{
		if ((i % 25) == 0) draw_set_alpha(0.8);
		else draw_set_alpha(0.4);
		draw_line_width(i*inc,0,i*inc,room_width,w);
	}


}


function load_grid() {
	
	//getting camera position
	var cam_x = camera_get_view_x(view_camera[0]);
	var cam_y = camera_get_view_y(view_camera[0]);
	var cam_w = camera_get_view_width(view_camera[0]);
	var cam_h = camera_get_view_height(view_camera[0]);
	var min_x = max(0,floor( cam_x / tile_size ) -1);
	var min_y = max(0,floor( cam_y / tile_size ) -1);
	var max_x = min(global.grid_width,floor( min_x + ( cam_w / tile_size ) ) +2);
	var max_y = min(global.grid_height,floor( min_y + ( cam_h / tile_size ) ) +2);
	
	
	//looping through the grid and drawing tiles
	for (var draw_x = min_x; draw_x < max_x; draw_x++) {
	
		for (var draw_y = min_y; draw_y < max_y; draw_y++) {
			
			var pos_x = draw_x * tile_size;
			var pos_y = draw_y * tile_size;
			
			var tile = ds_grid_get(global.tile_grid, draw_x, draw_y);
			var col = tile.col
			
			// normal tile drawing
			if (tile.main == ID.filled) { 
				
				//drawing the inside of the tile
				draw_rectangle_color(pos_x, pos_y, pos_x + tile_size - 1, pos_y + tile_size - 1, col, col, col, col, false);
				
				//drawing outline
				draw_sprite(spr_mapTiles, tile.subimg, pos_x, pos_y);
				
				
			}
		}
	}


	//old code archive
	
	if (69) {
	//for (var draw_x = min_x; draw_x < max_x; draw_x++) {
	
	//	for (var draw_y = min_y; draw_y < max_y; draw_y++) {
		
		
	//		var m = ds_grid_get(global.mainGrid,draw_x,draw_y)
	//		var n = ds_grid_get(global.SubimgGrid,draw_x,draw_y)
	//		if (m == undefined) m = 0;
	//		if (n == undefined) n = 0;
		
	//		if (m = ID.filled) {
	//			if (draw_x == tile_xx && draw_y == tile_yy && selecting_tile) {
	//				final_tile = n;
	//				draw_sprite(spr_mapTiles,n,draw_x*32,draw_y*32);
	//			}
	//			else {
	//				draw_sprite(spr_mapTiles,n,draw_x*32,draw_y*32);
	//			}
	//		}
	//	}
	//}


	////marker grid
	//for (var draw_x = min_x; draw_x < max_x; draw_x++) {
	
	//	for (var draw_y = min_y; draw_y < max_y; draw_y++) {
		
	//		var m = ds_grid_get(global.MarkerGrid,draw_x,draw_y)
	//		if (m == undefined) m = 0;
		
	//		if !(m == 0) {
	//			if (draw_x == tile_xx && draw_y == tile_yy && selecting_tile) {
	//				final_marker = m;
	//				draw_sprite(spr_marker,m-1,draw_x*32,draw_y*32);
	//			}
	//			else {
	//				draw_sprite(spr_marker,m-1,draw_x*32,draw_y*32);
	//			}
	//		}
				
			
	//	}
	//}}


	////door grid
	//if (g = "door") {
	//for (var draw_x = min_x; draw_x < max_x * 2; draw_x++) {
	
	//	for (var draw_y = min_y; draw_y < max_y * 2; draw_y++) {
		
		
	//		var m = ds_grid_get(global.DoorGrid,draw_x,draw_y);
	//		if (m == undefined) m = 0;
	//		var subimg = 0;
		
		
	//		if (m == 1 || m == 6 || m == 11 || m == 16) var subimg = 0;
	//		if (m == 2 || m == 7 || m == 12 || m == 17) var subimg = 1;
	//		if (m == 3 || m == 8 || m == 13 || m == 18) var subimg = 2;
	//		if (m == 4 || m == 9 || m == 14 || m == 19) var subimg = 3;
	//		if (m == 5 || m == 10 || m == 15 || m == 20) var subimg = 4;
	//		//  left	  right		up		   down
			
			
	//		if (!(floor(draw_x/2) == tile_xx && floor(draw_y/2) == tile_yy)) {
			
	//			if (m >= 1 && m <= 5) {
	//				draw_sprite_part(spr_doorTiles,subimg,0,2,4,28,draw_x*16,draw_y*16+2);
	//			}
	//			if (m >= 6 && m <= 10) {
	//				draw_sprite_part(spr_doorTiles,subimg,28,2,4,28,draw_x*16+12,draw_y*16+2);
	//			}
	//			if (m >= 11 && m <= 15) {
	//				draw_sprite_part(spr_doorTiles,subimg,2,0,28,4,draw_x*16+2,draw_y*16-16);
	//			}
	//			if (m >= 16 && m <= 20) {
	//				draw_sprite_part(spr_doorTiles,subimg,2,28,28,4,draw_x*16-14,draw_y*16+12);
	//			}

	//		}
			
	//	}
	//}}
	
	
	
	////drawing selected tile
	//var corner_x = (tile_xx)*32 + tile_size/2 - (tile_size*tile_xscale) / 2;
	//var corner_y = (tile_yy)*32 + tile_size/2 - (tile_size*tile_yscale) / 2;
	//var _w = tile_size * tile_xscale;
	//var _h = tile_size * tile_yscale;
	
	//if (final_tile != -1 && selecting_tile) {
	//	//drawing dark rectangle in the background
	//	draw_set_color(c_black);
	//	draw_set_alpha(0.35);
		
	//	draw_rectangle(min_x*32,min_y*32,max_x*32,max_y*32,false);
		
	//	draw_set_alpha(1);
	//	draw_set_color(c_white);
		
	//	//drawing selected tile
	//	draw_sprite_ext(spr_mapTiles,final_tile,corner_x,corner_y,tile_xscale,tile_yscale,0,c_white,1)
	//	if (final_marker != -1) draw_sprite_ext(spr_marker,final_marker - 1,corner_x,corner_y,tile_xscale,tile_yscale,0,c_white,1)
		
	//	//drawing selected door
	//	// stupid code for selected tiles with doors on it ;-;
	//	if (selecting_tile) {
	//	for (var draw_x = tile_xx*2; draw_x < tile_xx*2 + 2; draw_x++;) {
		
	//		for (var draw_y = tile_yy*2; draw_y < tile_yy*2 + 2; draw_y++;) {
			
	//			var m = ds_grid_get(global.DoorGrid,draw_x,draw_y);
	//			if (m == undefined) m = 0;
	//			var subimg = 0;
			
	//			if (m == 1 || m == 6 || m == 11 || m == 16) var subimg = 0;
	//			if (m == 2 || m == 7 || m == 12 || m == 17) var subimg = 1;
	//			if (m == 3 || m == 8 || m == 13 || m == 18) var subimg = 2;
	//			if (m == 4 || m == 9 || m == 14 || m == 19) var subimg = 3;
	//			if (m == 5 || m == 10 || m == 15 || m == 20) var subimg = 4;
	//			//  left	  right		up		   down
		
	//			if (m >= 1 && m <= 5) {
	//				draw_sprite_part_ext(spr_doorTiles,subimg,0,2,4,28,corner_x,corner_y+2,tile_xscale,tile_yscale,c_white,1);
	//			}
	//			if (m >= 6 && m <= 10) {
	//				draw_sprite_part_ext(spr_doorTiles,subimg,28,2,4,28,corner_x+_w-6 ,corner_y+2,tile_xscale,tile_yscale,c_white,1);
	//			}
	//			if (m >= 11 && m <= 15) {
	//				draw_sprite_part_ext(spr_doorTiles,subimg,2,0,28,4,corner_x+2,corner_y,tile_xscale,tile_yscale,c_white,1);
	//			}
	//			if (m >= 16 && m <= 20) {
	//				draw_sprite_part_ext(spr_doorTiles,subimg,2,28,28,4,corner_x+2,corner_y+_h-6,tile_xscale,tile_yscale,c_white,1);
	//			}
	//		}
	//	}}
	
		
	//	draw_set_color(c_lime);
		
	//	draw_sprite_ext(spr_cursor_tile_selected,0,corner_x - 2,corner_y - 2,tile_xscale,tile_yscale,0,c_lime,1)
		
	}
}
	
	
function add_text_message(msg, lifetime) {
	
	grid_shift_x_up(global.text_grid);
	
	//setting the new text
	//message
	ds_grid_set(global.text_grid, 0, text.messg, msg);
	//lifetime
	ds_grid_set(global.text_grid, 0, text.life, lifetime);
	//alpha
	ds_grid_set(global.text_grid, 0, text.alph, 1);
	
}


function grid_shift_x_up(grid) {
	
	var grid_length = ds_grid_width(grid)
	for (var i = 0; i < grid_length; i++) {
		
		//getting variables
		var pos = (i - grid_length) * -1 - 1;
		var m = ds_grid_get(grid, pos, text.messg);
		var _lifetime = ds_grid_get(grid, pos, text.life);
		var _alpha = ds_grid_get(grid, pos, text.alph);
		
		if (m != 0) {
			
			//checking if grid is long enough for shift
			if (pos = grid_length) {
				ds_grid_resize(grid, grid_length + 1, 3)
			}
			
			//shifting the value one position up
			ds_grid_set(grid, pos + 1, text.messg, m);
			ds_grid_set(grid, pos + 1, text.life, _lifetime);
			ds_grid_set(grid, pos + 1, text.alph, _alpha);
			
			//deleting the old value
			ds_grid_set(grid, pos, text.messg, 0);
			ds_grid_set(grid, pos, text.life, 0);
			ds_grid_set(grid, pos, text.alph, 0);
			
		}
		
	}
	
}
	
	
function update_text_message(_x, _y) {
	
	var grid = global.text_grid;
	var grid_length = ds_grid_width(grid);
	var spacing = 22;
	
	for (var i = 0; i < grid_length; i++) {
		
		var m = ds_grid_get(grid, i, text.messg);
		var _lifetime = ds_grid_get(grid, i, text.life);
		var _alpha = ds_grid_get(grid, i, text.alph);
		
		//drawing the text
		if (m != 0) {
			draw_set_alpha(_alpha)
			draw_text(_x, _y - i * spacing, m)
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
	
}