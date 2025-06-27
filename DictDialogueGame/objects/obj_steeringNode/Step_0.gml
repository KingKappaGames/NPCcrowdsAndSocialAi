if(mouse_check_button(mb_middle)) {
	if(point_distance(x, y, mouse_x, mouse_y) < 35) {
		x = mouse_x;
		y = mouse_y;
	}
}