function circle_menu(total_options,circle_x,circle_y,circle_radius,min_radius,dir_offset) {
	
	// Select option from circle menu
	var option_angle_range = (360/total_options);
	var dis = point_distance( circle_x , circle_y , mouse_x , mouse_y );
	if( dis < circle_radius && dis > min_radius )
	{
	    var dir = point_direction( circle_x , circle_y , mouse_x , mouse_y ) + dir_offset;
		if (dir > 360) dir -= 360
		if (dir < 0) dir += 360
	    return( floor( dir / option_angle_range ) );
	}
	else
	{
		if (dis > circle_radius) {
			return( -1 )
		}
		
		if (dis < min_radius) {
			return( total_options );
		}
	}
}

