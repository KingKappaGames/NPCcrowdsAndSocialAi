if(live_call()) { return live_result }

event_inherited();

draw_circle(x, y, 10, false);

if(instance_exists(directId)) {
	draw_circle_color(directId.x, directId.y, 18, c_red, c_blue, true);
	draw_arrow(directId.x, directId.y, mouse_x, mouse_y, 20);
}