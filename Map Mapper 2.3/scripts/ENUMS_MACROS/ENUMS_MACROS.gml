enum ID {
	empty = 0,
	filled = 1
}

enum menu_state {
	nothing,
	color_menu,
	ig_menu
}

enum tool {
	pen,
	color_brush,
	door_tool,
	marker_tool,
	selector,
	eyedropper,
	hammer
}

enum marker {
	empty = -4,
}

enum hatch {
	empty,
	filled
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
	alph,
	col
}


#macro tile_size 32 
#macro border_margin 64
#macro extension ".mf"

#macro default_markers "https://cdn.discordapp.com/attachments/800903643824914453/843241137228480512/mm_basic_markers.png"
#macro default_tile_amount 20