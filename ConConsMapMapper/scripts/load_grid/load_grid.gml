//looping through the grids

for (var i = 0; i < ds_grid_width(global.mainGrid); i++) {
	
	for (var j = 0; j< ds_grid_height(global.mainGrid); j++){
		
	
		//main Grid		
		var m = ds_grid_get(global.mainGrid,i,j)
		var n = ds_grid_get(global.SubimgGrid,i,j)
		
		if (m = ID.filled) {
			draw_sprite(spr_mapTiles,n,i*32,j*32);
		}
			
		//door grid
		switch (ds_grid_get(global.DoorGrid,i,j)) {
			case (0):
				break;
				
			default:
				
				//drawing sprite
				var m = ds_grid_get(global.DoorGrid,i,j);
					
				if (m == 1) draw_sprite(spr_doorTilesL,subimg,i*32,j*32);
				if (m == 2) draw_sprite(spr_doorTilesR,subimg,i*32,j*32);
				if (m == 3) draw_sprite(spr_doorTilesU,subimg,i*32,j*32);
				if (m == 4) draw_sprite(spr_doorTilesD,subimg,i*32,j*32);
				
				break;
		}
	}
}
show_debug_message(current_time);