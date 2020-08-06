var g = argument[0];

for (var i = 0; i < ds_grid_width(g); i++) {
	
	for (var j = 0; j< ds_grid_height(g); j++){
		
		switch (ds_grid_get(g,i,j)){
			case (marker.empty):
			
				break;
				
			default:
				
				var m = ds_grid_get(g,i,j);
				draw_sprite(spr_marker,m-1,i*32,j*32);
				
				break;
			
		}
	}
}