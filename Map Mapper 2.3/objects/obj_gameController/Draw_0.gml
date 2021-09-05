//start
draw_set_alpha(1);
draw_set_color(c_white);

//drawing the grid
draw_set_color(c_gray);
draw_grid(global.grid_width * tile_size, global.grid_height * tile_size, 1, tile_size);
draw_set_alpha(1);

draw_set_color(c_white);
load_grid();

//end
draw_set_alpha(1);
draw_set_color(c_white);