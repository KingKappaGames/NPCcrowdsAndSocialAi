if(instance_exists(target)) {
	var _dir = point_direction(x, y, target.x, target.y);
	var _dist = point_distance(x, y, target.x, target.y);
	
	draw_arrow(x, y, x + dcos(_dir) * max(_dist - 30, 0), y - dsin(_dir) * max(_dist - 30, 0), 10);
	draw_set_color(c_red);
	
	for(var _i = array_length(data) - 1; _i >= 0; _i--) {
		draw_set_halign(fa_right);
		draw_text_transformed(x + 60, y - 200 + _i * 12, data[_i], .8, .8, 0);
		draw_set_halign(fa_left);
		draw_text_transformed(x + 70, y - 200 + _i * 12, dataNames[_i], .8, .8, 0);
	}
	
	draw_set_color(c_white);
} else {
	instance_destroy();
}