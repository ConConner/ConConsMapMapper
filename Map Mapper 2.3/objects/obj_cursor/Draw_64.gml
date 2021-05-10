display_set_gui_size(global.view_width, global.view_height);

draw_set_color(c_white);
draw_set_alpha(1);

//drawing the corners
//top left
draw_sprite(spr_cursor_edge, 0, x - current_selection_w, y - current_selection_h);
//top right
draw_sprite_ext(spr_cursor_edge, 0, x + current_selection_w, y - current_selection_h, -1, 1, image_angle, c_white, 1);
//bottom left
draw_sprite_ext(spr_cursor_edge, 0, x - current_selection_w, y + current_selection_h, 1, -1, image_angle, c_white, 1);
//bottom right
draw_sprite_ext(spr_cursor_edge, 0, x + current_selection_w, y + current_selection_h, -1, -1, image_angle, c_white, 1);

//drawing middle icon
//setting the alpha
var tile = ds_grid_get(global.tile_grid,global.xx,global.yy);

if (cursor_mode == curs_mode.on_grid) {

	if (tile.main == ID.filled) {
		goal_icon_alpha = 0;
	}
	
	if (tile.main == ID.empty || obj_gameController.placed_tile) {
		goal_icon_alpha = 1;
	}
	
	//drawing the icon
	if (mouse_check_button(mb_right)) {
	
		goal_icon_frame = 4;
	} else {
	
		goal_icon_frame = 0;
	}
	
} else {
	goal_icon_alpha = 0;
}

if (cursor_mode == curs_mode.drag_to_move) {
	
	goal_icon_frame = 5;
	icon_frame = 5;
	goal_icon_alpha = 1;
	
}


//text after hovering over button
var _button = button_check();
if (_button != 0) {
	if (_button.button_enabled && _button.active) {
		
		draw_set_alpha(1);
		var _left = cursor_x - goal_selection_w / 2 - 4;
		var _top = cursor_y - goal_selection_h / 2;
	
		switch (_button) {
		
			case obj_gameController.color_button:
				draw_text(_left, _top - 22, "COLOR MENU");
				break;
				
			case obj_gameController.rgb_code_selection:
				draw_text(_left - 4, _top - 14, "CLICK TO COPY");
				break;
				
			case obj_gameController.color_decline_button:
				draw_text(_left + 6, _top - 17, "CANCEL");
				break;
				
			case obj_gameController.color_confirm_button:
				draw_text(_left + 6, _top - 17, "SAVE");
				break;
		
		}
	}
}


draw_set_alpha(icon_alpha);
draw_sprite(spr_cursor_add, icon_frame, x, y);

//resetting alpha
draw_set_alpha(1);