if (ds_exists(global.mainGrid,ds_type_grid))
{
	ds_grid_destroy(global.mainGrid);
}

if (ds_exists(global.SubimgGrid,ds_type_grid))
{
	ds_grid_destroy(global.SubimgGrid);
}

if (ds_exists(global.RoomGrid,ds_type_grid))
{
	ds_grid_destroy(global.RoomGrid);
}

if (ds_exists(global.ColorGrid,ds_type_grid))
{
	ds_grid_destroy(global.ColorGrid);
}

if (ds_exists(global.MarkerGrid,ds_type_grid))
{
	ds_grid_destroy(global.MarkerGrid);
}

if (ds_exists(global.DoorGrid,ds_type_grid))
{
	ds_grid_destroy(global.DoorGrid);
}