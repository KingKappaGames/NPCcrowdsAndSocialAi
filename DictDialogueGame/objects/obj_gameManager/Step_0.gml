if(keyboard_check_released(ord("F"))) {
	window_set_fullscreen(!window_get_fullscreen());
}

if(irandom(750) == 0) {
	global.weather = choose("sunny", "overcast", "rain", "wind", "storm", "snow", "mild", "hot", "cold", "drought");
}

if(keyboard_check_released(vk_f11)) {
	global.weather = choose("sunny", "overcast", "rain", "wind", "storm", "snow", "mild", "hot", "cold", "drought");
	global.time = choose("day", "night", "morning", "dusk", "noon", "middle of the night");
	global.territory = choose("pride lands", "dark realm", "quiet vegas", "surface", "reaches");
}