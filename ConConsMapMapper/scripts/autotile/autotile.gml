var xx = argument[0];
var yy = argument[1];


if (ds_grid_get(global.mainGrid,xx,yy) == ID.filled) {
	
	var up = false;
	var down = false;
	var left = false;
	var right = false;
	var mrDown = false;
	var mrUp = false;
	var mrLeft = false;
	var mrRight = false;

	//Auto tiling
	var myRoom = ds_grid_get(global.RoomGrid,xx,yy);
	var myColor = ds_grid_get(global.ColorGrid,xx,yy);
 
	if (myRoom == ds_grid_get(global.RoomGrid,xx,yy - 1)) mrUp = true;
	else mrUp = false;
	if (myRoom == ds_grid_get(global.RoomGrid,xx,yy + 1)) mrDown = true;
	else mrDown = false;
	if (myRoom == ds_grid_get(global.RoomGrid,xx - 1,yy)) mrLeft = true;
	else mrLeft = false;
	if (myRoom == ds_grid_get(global.RoomGrid,xx + 1,yy)) mrRight = true;
	else mrRight = false;
 
	if (yy !=0) up = ds_grid_get(global.mainGrid,xx,yy - 1) * mrUp;
	if (yy !=global.grid_size-1) down = ds_grid_get(global.mainGrid,xx,yy + 1) * mrDown;
	if (xx !=0) left = ds_grid_get(global.mainGrid,xx - 1,yy) * mrLeft;
	if (xx !=global.grid_size-1) right = ds_grid_get(global.mainGrid,xx + 1,yy) * mrRight;
 
	return myColor * 16 + (8*right + 4*left + 2*down + up) + 1;
	
}
else return 0;