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

if(irandom(150) == 0) {
	if(instance_number(obj_radiantFire) < 5) {
		instance_create_depth(irandom_range(-500, 500), irandom_range(-500, 500), 0, obj_radiantFire);
	}
}

global.dayTime += .035;
ppxRenderer.SetEffectParameter(FF_SATURATION, PP_SATURATION, 1 - (.3 + dsin(global.dayTime) * .3));

crystalRenderer.SetAmbientIntensity(min(.7 + dsin(global.dayTime) * .5, 1));


if(keyboard_check_released(ord("T"))) {
	global.dayTime = random(360);
}