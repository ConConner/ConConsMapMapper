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

#macro default_markers "https://images-ext-1.discordapp.net/external/pTxKeUe6jUnxEb2WTKUAM6l1DsYmRz2LQG6qlG9wv2I/https/media.discordapp.net/attachments/473935669144846357/885118483560562688/mm_basic_markers_extended.png"
#macro default_tile_amount 30