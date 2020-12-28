if (mouse_hovering_over_object()) {
	draw_sprite(sprite_index,1,x,y-2);
}
else {
	draw_self();
}