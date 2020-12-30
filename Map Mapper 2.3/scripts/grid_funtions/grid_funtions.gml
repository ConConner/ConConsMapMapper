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


function load_grid(g) {
	//looping through the grids
	//getting view size
	var cam_x = camera_get_view_x(view_camera[0]);
	var cam_y = camera_get_view_y(view_camera[0]);
	var cam_w = camera_get_view_width(view_camera[0]);
	var cam_h = camera_get_view_height(view_camera[0]);
	var min_x = max(0,floor( cam_x / tile_size ) -1);
	var min_y = max(0,floor( cam_y / tile_size ) -1);
	var max_x = min(global.grid_size,floor( min_x + ( cam_w / tile_size ) ) +2);
	var max_y = min(global.grid_size,floor( min_y + ( cam_h / tile_size ) ) +2);
	
	var final_marker = -1;
	var final_tile = -1;
	var final_door = -1;


	//main grid
	if (g = "main") {
	for (var draw_x = min_x; draw_x < max_x; draw_x++) {
	
		for (var draw_y = min_y; draw_y < max_y; draw_y++) {
		
		
			var m = ds_grid_get(global.mainGrid,draw_x,draw_y)
			var n = ds_grid_get(global.SubimgGrid,draw_x,draw_y)
			if (m == undefined) m = 0;
			if (n == undefined) n = 0;
		
			if (m = ID.filled) {
				//if (global.xx = draw_x && global.yy = draw_y) {
					//final_tile = n;
				//}
				//else {
					draw_sprite(spr_mapTiles,n,draw_x*32,draw_y*32);
				//}
			}
		}
	}


	//marker grid
	for (var draw_x = min_x; draw_x < max_x; draw_x++) {
	
		for (var draw_y = min_y; draw_y < max_y; draw_y++) {
		
			var m = ds_grid_get(global.MarkerGrid,draw_x,draw_y)
			if (m == undefined) m = 0;
		
			if !(m == 0) {
				draw_sprite(spr_marker,m-1,draw_x*32,draw_y*32);
			}
				
			
		}
	}}


	//door grid
	if (g = "door") {
	for (var draw_x = min_x; draw_x < max_x * 2; draw_x++) {
	
		for (var draw_y = min_y; draw_y < max_y * 2; draw_y++) {
		
		
			var m = ds_grid_get(global.DoorGrid,draw_x,draw_y);
			if (m == undefined) m = 0;
			var subimg = 0;
		
		
			if (m == 1 || m == 6 || m == 11 || m == 16) var subimg = 0;
			if (m == 2 || m == 7 || m == 12 || m == 17) var subimg = 1;
			if (m == 3 || m == 8 || m == 13 || m == 18) var subimg = 2;
			if (m == 4 || m == 9 || m == 14 || m == 19) var subimg = 3;
			if (m == 5 || m == 10 || m == 15 || m == 20) var subimg = 4;
		
		
			if (m >= 1 && m <= 5) {
				draw_sprite_part(spr_doorTiles,subimg,0,2,4,28,draw_x*16,draw_y*16+2);
			}
			if (m >= 6 && m <= 10) {
				draw_sprite_part(spr_doorTiles,subimg,28,2,4,28,draw_x*16+12,draw_y*16+2);
			}
			if (m >= 11 && m <= 15) {
				draw_sprite_part(spr_doorTiles,subimg,2,0,28,4,draw_x*16+2,draw_y*16-16);
			}
			if (m >= 16 && m <= 20) {
				draw_sprite_part(spr_doorTiles,subimg,2,28,28,4,draw_x*16-14,draw_y*16+12);
			}
		}
	}}
	
	var corner_x = global.xx*32 - tile_size/4;
	var corner_y = global.yy*32 - tile_size/4;
	
	if (final_tile != -1) {
		draw_sprite_ext(spr_mapTiles,final_tile,global.xx*32 - tile_size/4,global.yy*32 - tile_size/4,1.5,1.5,0,c_white,1)
		draw_set_color(c_aqua);
		draw_rectangle(corner_x - 1,corner_y - 1,corner_x + tile_size * 1.5 + 1,corner_y + tile_size * 1.5 + 1,true)
		draw_rectangle(corner_x - 2,corner_y - 2,corner_x + tile_size * 1.5 + 2,corner_y + tile_size * 1.5 + 2,true)
		draw_rectangle(corner_x - 3,corner_y - 3,corner_x + tile_size * 1.5 + 3,corner_y + tile_size * 1.5 + 3,true)
	}


}