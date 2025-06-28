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

//ppxRenderer.SetEffectParameters(FF_COLORIZE, [PP_COLORIZE_INTENSITY], [.5 + dsin(current_time / 70)]);

if(mouse_check_button_released(mb_left)) {
	var _light = instance_create_depth(mouse_x, mouse_y, -mouse_y, obj_pointLight);
	_light.color = #ffffaa;
	_light.radius = 512;
	_light.intensity = .7;
	_light.castShadows = true;
	_light.selfShadows = true;
}

if(mouse_check_button_released(mb_right)) {
	var shadow = new Crystal_Shadow(noone, CRYSTAL_SHADOW.STATIC);
	shadow.x = mouse_x;
	shadow.y = mouse_y;
	shadow.depth = -999;
	shadow.AddMesh(new Crystal_ShadowMesh().FromRect(100, 100, true));
	shadow.shadowLength = 10;
	shadow.Apply();
}