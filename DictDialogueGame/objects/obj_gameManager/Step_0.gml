if(keyboard_check_released(ord("F"))) {
	window_set_fullscreen(!window_get_fullscreen());
}

if(irandom(750) == 0) {
	global.weather = choose("sunny", "overcast", "rain", "wind", "storm", "snow", "mild", "hot", "cold", "drought");
}