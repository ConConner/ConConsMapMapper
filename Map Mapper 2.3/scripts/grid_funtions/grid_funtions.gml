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
			
			
			var tile = ds_grid_get(global.tile_grid, draw_x, draw_y);
			
			draw_set_font(fnt_simple_text);
			draw_text(draw_x * tile_size, draw_y * tile_size, tile.main);
			
			
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