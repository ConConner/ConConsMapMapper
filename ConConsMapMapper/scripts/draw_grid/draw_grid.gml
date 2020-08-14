var w = argument[0];
var inc = argument[1];

for (var i = 0; i < room_height/inc+1; i += 1)
{
	if ((i % 25) == 0) draw_set_alpha(0.8);
	else draw_set_alpha(0.4);
	draw_line_width(0,i*inc,room_width,i*inc,w);

}


for (var i = 0; i < room_width/inc+1; i += 1)
{
	if ((i % 25) == 0) draw_set_alpha(0.8);
	else draw_set_alpha(0.4);
	draw_line_width(i*inc,0,i*inc,room_width,w);
}