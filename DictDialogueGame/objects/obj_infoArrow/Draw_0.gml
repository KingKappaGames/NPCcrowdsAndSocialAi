if(instance_exists(target)) {
	var _dir = point_direction(x, y, target.x, target.y);
	var _dist = point_distance(x, y, target.x, target.y);
	
	draw_arrow(x, y, x + dcos(_dir) * max(_dist - 30, 0), y - dsin(_dir) * max(_dist - 30, 0), 10);
	draw_set_color(c_red);
	
	var _xText = x + dcos(_dir) * _dist * .4;
	var _yText = y - dsin(_dir) * _dist * .4;
	for(var _i = array_length(data) - 1; _i >= 0; _i--) {
		draw_set_halign(fa_right);
		draw_text_transformed(_xText - 5, _yText + _i * 12, string_format(data[_i], 9, 5), .8, .8, 0);
		draw_set_halign(fa_left);
		draw_text_transformed(_xText + 5, _yText + _i * 12, dataNames[_i], .8, .8, 0);
	}
	
	draw_set_color(c_white);
} else {
	instance_destroy();
}