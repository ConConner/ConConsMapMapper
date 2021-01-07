/////////////////////////////////////////////////////////////////////////////////
//---INFORMATION---
//
//
//
//
//
//
//
//
/////////////////////////////////////////////////////////////////////////////////

enum ID {
	empty = 0,
	filled = 1
}

enum c {
	blue,
	aqua,
	green,
	yellow,
	orange,
	red,
	grey,
	purple,
}

enum marker {
	empty = 0,
	circle = 1,
	dot = 2,
	exclamation = 3,
	up = 5,
	down = 4,
	start = 6,
}
	
enum dir {
	left,
	right,
	up,
	down,
	none,
}


#macro tile_size 32 
#macro border_margin 64
#macro extension ".cmf"