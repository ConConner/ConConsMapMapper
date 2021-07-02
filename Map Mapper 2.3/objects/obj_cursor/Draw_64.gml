display_set_gui_size(global.view_width, global.view_height);

draw_set_color(c_white);
draw_set_alpha(cursor_alpha);

//drawing the corners
//top left
draw_sprite(spr_cursor_edge, 0, x - current_selection_w, y - current_selection_h);

//top right
draw_sprite_ext(spr_cursor_edge, 0, x + current_selection_w, y - current_selection_h, -1, 1, image_angle, c_white, cursor_alpha);

//bottom left
draw_sprite_ext(spr_cursor_edge, 0, x - current_selection_w, y + current_selection_h, 1, -1, image_angle, c_white, cursor_alpha);

//bottom right
draw_sprite_ext(spr_cursor_edge, 0, x + current_selection_w, y + current_selection_h, -1, -1, image_angle, c_white, cursor_alpha);


//drawing middle icon
//setting the alpha
var tile = ds_grid_get(global.tile_grid,global.xx,global.yy);


if (cursor_mode == curs_mode.on_grid) {
	
	switch (obj_gameController.current_tool) {
		
		case tool.pen: {
			goal_cursor_alpha = 1;
			icon_sprite = spr_cursor_middle;
			
			if (tile.main == ID.filled) {
				goal_icon_alpha = 0;
			}
			if (tile.main == ID.empty || obj_gameController.placed_tile) {
				goal_icon_alpha = 1;
			}
	
			//drawing the icon
			if (mouse_check_button(mb_right)) goal_icon_frame = 4;
			else goal_icon_frame = 0;
			break; }
			
		case tool.eyedropper: {
			goal_cursor_alpha = 0;
			goal_icon_alpha = 1;
			goal_icon_frame = 1;
			icon_frame = 1;
			icon_sprite = spr_cursor_static;
			
			break; }
			
		case tool.color_brush: {
			goal_cursor_alpha = 1;
			icon_sprite = spr_cursor_static;
			
			if (tile.main == ID.filled) {
				goal_icon_alpha = 1;
			}
			if (tile.main == ID.empty) {
				goal_icon_alpha = 0;
			}
	
			//drawing the icon
			if (mouse_check_button(mb_right)) icon_frame = 3;
			else icon_frame = 2;
			
			break; }
			
		case tool.door_tool: {
			goal_cursor_alpha = 1;
			icon_sprite = spr_cursor_selector;
			if (tile.main == ID.filled) {
				goal_icon_alpha = 1;
			}
			if (tile.main == ID.empty && !obj_gameController.adding_connection) {
				goal_icon_alpha = 0;
			}
			
			//drawing the icon seperately
			draw_set_alpha(icon_alpha);
			if (!obj_gameController.adjust_cursor) {
				
				//Showing possible door locations
				var tile_up = 0;
				var tile_right = 0;
				var tile_down = 0;
				var tile_left = 0;
				var _tile_pos_x = obj_gameController.connection_xx;
				var _tile_pos_y = obj_gameController.connection_yy;
				
				if (_tile_pos_x != 0) tile_left = ds_grid_get(global.tile_grid,_tile_pos_x - 1,_tile_pos_y);
				if (_tile_pos_x != global.grid_width - 1) tile_right = ds_grid_get(global.tile_grid,_tile_pos_x + 1,_tile_pos_y);
				if (_tile_pos_y != 0) tile_up = ds_grid_get(global.tile_grid,_tile_pos_x,_tile_pos_y - 1);
				if (_tile_pos_y != global.grid_height - 1) tile_down = ds_grid_get(global.tile_grid,_tile_pos_x,_tile_pos_y + 1);
				
				if (tile_up != 0) if (tile_up.main) draw_sprite(spr_cursor_door, 0, x, y);
				if (tile_right != 0) if (tile_right.main) draw_sprite(spr_cursor_door, 1, x, y);
				if (tile_down != 0) if (tile_down.main) draw_sprite(spr_cursor_door, 2, x, y);
				if (tile_left != 0) if (tile_left.main) draw_sprite(spr_cursor_door, 3, x, y);
				
			} else {
				//showing door edge
				var _spr = 0;
				if (obj_gameController.mLeft) _spr = spr_cursor_door_second;
				if (obj_gameController.mRight) _spr = spr_cursor_door_delete;
				
				if (obj_gameController.connection_yy2 != obj_gameController.connection_yy) draw_sprite(_spr, 0, x, y);
				if (obj_gameController.connection_xx2 != obj_gameController.connection_xx) draw_sprite(_spr, 1, x, y);
				if (obj_gameController.connection_yy2 != obj_gameController.connection_yy) draw_sprite(_spr, 2, x, y);
				if (obj_gameController.connection_xx2 != obj_gameController.connection_xx) draw_sprite(_spr, 3, x, y);
			}
			
			draw_set_alpha(1);
			
			break; }
			
		case tool.marker_tool: {
			goal_cursor_alpha = 1;
			icon_sprite = spr_cursor_middle;
			
			if (tile.main == ID.filled) {
				goal_icon_alpha = 1;
			}
			if (tile.main == ID.empty || obj_gameController.placed_tile) {
				goal_icon_alpha = 0;
			}
	
			//drawing the icon
			if (mouse_check_button(mb_right)) goal_icon_frame = 4;
			else goal_icon_frame = 0;
			break; }
		
		case tool.hammer: {
			goal_cursor_alpha = 1;
			
			var _subimg = tile.subimg;
			if (_subimg == 10 || _subimg == 6 || _subimg == 5 || _subimg == 9 || _subimg == 12 || _subimg == 3) {
				icon_sprite = spr_cursor_static;
				goal_icon_alpha = 1;
				icon_frame = 4;
				goal_icon_frame = 4;
			} else if (_subimg >= 16) {
				icon_sprite = spr_cursor_static;
				goal_icon_alpha = 1;
				icon_frame = 5;
				goal_icon_frame = 4;
			} else goal_icon_alpha = 0;
			
			break; }
	}
	
} else {
	goal_cursor_alpha = 1;
	goal_icon_alpha = 0;
}

if (cursor_mode == curs_mode.drag_to_move) {
	
	icon_sprite = spr_cursor_static;
	goal_cursor_alpha = 1;
	goal_icon_frame = 0;
	icon_frame = 0;
	goal_icon_alpha = 1;
	
}


//text after hovering over button
var _button = button_check();
if (_button != 0) {
	if (_button.button_enabled && _button.active) {
		
		draw_set_alpha(1);
		goal_cursor_alpha = 1;
		var _left = cursor_x - goal_selection_w / 2 - 4;
		var _top = cursor_y - goal_selection_h / 2;
	
		switch (_button) {
		
			case obj_gameController.color_button: {
				draw_text(_left + 2, _top - 45, "COLOR MENU\n(CTRL+C)");
				break; }
				
			case obj_gameController.rgb_code_selection: {
				draw_text(_left - 4, _top - 14, "CLICK TO COPY");
				break; }
				
			case obj_gameController.color_decline_button: {
				draw_text(_left + 6, _top - 17, "CANCEL");
				break; }
				
			case obj_gameController.color_confirm_button: {
				draw_text(_left + 6, _top - 17, "SAVE");
				break; }
				
			case obj_gameController.igmenu_button: {
				draw_text(_left + 2, _top + 44, "MENU (ESC)");
				break; }
				
			#region menu buttons
			case obj_gameController.pen_tool_button: {
				draw_text(_left + 2, _top + 69, "PEN TOOL (P)");
				break; }
			case obj_gameController.eyedropper_tool_button: {
				draw_text(_left + 2, _top + 69, "color picker (ALT)"); 
				break; }
			case obj_gameController.color_brush_tool_button: {
				draw_text(_left + 2, _top + 69, "color brush (B)");
				break; }
			case obj_gameController.door_tool_button: {
				draw_text(_left + 2, _top + 69, "connection tool (C)");
				break; }
			case obj_gameController.marker_tool_button: {
				draw_text(_left + 2, _top + 69, "marker tool (M)");
				break; }
			case obj_gameController.selection_tool_button: {
				draw_text(_left + 2, _top + 69, "selection tool (S)");
				break; }
			case obj_gameController.hammer_tool_button: {
				draw_text(_left + 2, _top + 69, "hammer tool (H)");
				break; }
			case obj_gameController.save_button: {
				draw_text(_left + 2, _top + 69, "save map");
				break; }
			case obj_gameController.load_button: {
				draw_text(_left - 17, _top + 69, "load map");
				break; }
			#endregion
		
		}
	}
}


draw_set_alpha(icon_alpha);
draw_sprite(icon_sprite, icon_frame, x, y);

//resetting alpha
draw_set_alpha(1);