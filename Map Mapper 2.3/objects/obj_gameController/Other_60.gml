if ds_map_find_value(async_load, "id") == checking_sprite {
	if ds_map_find_value(async_load, "status") >= 0 {
		
		//checking if sprite is valid
		if (sprite_get_height(checking_sprite) == 32) {
			if (sprite_get_width(checking_sprite) % 32 != 0) {
				add_text_message("The image has to be divideable by 32 !", 3.5, c_yellow);
				add_text_message("Default marker set loaded !", 4, c_yellow);
				marker_url = default_markers;
				tile_amount = default_tile_amount;
			}
			else {
				//calculatin subimage amount
				tile_amount = sprite_get_width(checking_sprite) / 32;
				
				add_text_message("Custom marker set loaded", 4, c_lime);
				
			}
		}
		else {
			
			add_text_message("The image has to be 32 pixels high !", 3.5, c_yellow);
			add_text_message("Default marker set loaded !", 4, c_yellow);
			marker_url = default_markers;
			tile_amount = default_tile_amount;
			
		}
		
		marker_sprite = sprite_add(marker_url, tile_amount, false, false, 0, 0);
		sprite_delete(checking_sprite);
	}
}