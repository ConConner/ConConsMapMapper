image_speed = 0;
timer = 0;
yy = y

gridX = global.xx;
gridY = global.yy;

mouseTileX = 0;
mouseTileY = 0;

room_left = ds_grid_get(global.mainGrid,gridX - 1, gridY);
room_right = ds_grid_get(global.mainGrid,gridX + 1, gridY);
room_up = ds_grid_get(global.mainGrid,gridX,gridY - 1);
room_down = ds_grid_get(global.mainGrid,gridX,gridY + 1);