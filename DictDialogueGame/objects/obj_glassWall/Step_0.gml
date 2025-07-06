if(mouse_check_button(mb_left)) {
	if(point_distance(x, y, mouse_x, mouse_y) < 100) {
		x = mouse_x;
		y = mouse_y;
	}
}

depth = -y;