if(live_call()) { return live_result }

if(mouse_check_button_released(mb_left)) {
	var _distToCenter = point_distance(x, y, mouse_x, mouse_y);
	if(_distToCenter < 200) {
		
		msg("clicked general emotions");
		
		var _checkDist = 40;
		var _checkAngle = 0;
		var _checkRadius = 0;
		for(var _i = 0; _i < emotionCount; _i++) {
			_checkDist = 40 + emotionImpacts[_i] * 15;
			_checkRadius = 18 - emotionImpacts[_i] * 2;
			
			if(point_distance(mouse_x, mouse_y, x + dcos(_checkAngle) * _checkDist, y - dsin(_checkAngle) * _checkDist) < _checkRadius) {
				msg("clicked emotion: " + string(_i));
				emotionStates[_i] *= .5;
				emotionImpacts[_i] += .3;
				break; // not going to find other emotions if you already found one (you shouldn't anyway, even if you could!)
			}
			
			_checkAngle += 360 / emotionCount;
		}
	}
}

for(var _i = 0; _i < emotionCount; _i++) {
	emotionImpacts[_i] = lerp(emotionImpacts[_i], 0, .02);
	emotionStates[_i] = lerp(emotionStates[_i], .5, .0005);
}