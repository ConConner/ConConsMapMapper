enum ID {
	empty = 0,
	filled = 1
}

enum menu_state {
	nothing,
	color_menu
}

enum marker {
	empty = 0,
	circle = 1,
	dot = 2,
	exclamation = 3,
	up = 8,
	down = 9,
	left = 6,
	right = 7,
	boss = 5,
	start = 4
}

enum hatch {
	empty,
	blue,
	red,
	green,
	yellow,
	none
}
	
enum dir {
	left,
	right,
	up,
	down,
	none
}

enum text {
	messg,
	life,
	alph
}


#macro tile_size 32 
#macro border_margin 64
#macro extension ".mf"