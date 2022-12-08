enum ID {
	empty,
	filled
}

enum menu_state {
	nothing,
	color_menu,
	settings_menu,
	save_menu,
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

enum text {
	messg,
	life,
	alph,
	col
}


#macro tile_size 32 
#macro border_margin 64

#macro default_markers "https://cdn.discordapp.com/attachments/885112600575238194/1050460064877654096/mm_basic_markers_extended.png"
#macro default_tile_amount 38