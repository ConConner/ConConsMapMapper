if (ds_exists(global.tile_grid,ds_type_grid))
{
	ds_grid_destroy(global.tile_grid);
}

if (ds_exists(global.text_grid,ds_type_grid))
{
	ds_grid_destroy(global.text_grid);
}