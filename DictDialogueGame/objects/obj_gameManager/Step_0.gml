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

global.dayTime += .035;
ppxRenderer.SetEffectParameter(FF_SATURATION, PP_SATURATION, 1 - (.3 + dsin(global.dayTime) * .3));

crystalRenderer.SetAmbientIntensity(min(.7 + dsin(global.dayTime) * .5, 1));

if(keyboard_check(vk_enter)) { // allow adding but you have to hit control so it's out of the way
if(mouse_check_button_released(mb_left)) {
	var _light = instance_create_depth(mouse_x, mouse_y, -mouse_y, obj_pointLight);
	_light.color = #ffffaa;
	_light.radius = 512;
	_light.intensity = .55;
	_light.castShadows = true;
	_light.selfShadows = true;
	_light.shaderType = LIGHT_SHADER_BRDF;
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
}

if(keyboard_check_released(ord("T"))) {
	global.dayTime = random(360);
}