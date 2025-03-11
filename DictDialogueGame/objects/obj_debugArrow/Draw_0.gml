draw_set_color(make_color_rgb(180, 255 * feeling, 180 * feeling));
draw_arrow(x, y, targetX, targetY, 30);

duration--;
if(duration <= 0) {
	instance_destroy();
}