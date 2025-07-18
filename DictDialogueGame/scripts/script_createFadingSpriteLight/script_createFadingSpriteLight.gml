function script_createFadingSpriteLight(xx, yy, depthSet, radiusSet, brightness, duration, colorSet = c_white, fadeCurve = curve_glowFade, castShadows = 1, shader = LIGHT_SHADER_BRDF) {
	var _light = instance_create_depth(xx, yy, depthSet, obj_fadingPointLight);
	with(_light) {
		_light.color = colorSet;
		_light.radius = radiusSet;
		_light.sizeOriginalX = radiusSet;
		_light.intensity = brightness;
		_light.shaderType = shader;
		
		_light.timerMax = duration;
		_light.timer = duration;
	}
	
	return _light;
}