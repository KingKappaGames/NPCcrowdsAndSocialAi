if( live_call()) { return live_result }

if(instance_exists(sourceId)) {
	originX = sourceId.x;
	originY = sourceId.y;
}

var _fade = 0;
var _fadePortion = 1;
if(fadeTime > 0 && fadeTime <= fadeTimeMax) {
	_fadePortion = 1 - (fadeTime / fadeTimeMax);
	_fade = -((fadeTime * 2) / fadeTimeMax); // 0 to -2     to cut off alpha half way to over
	if(multipleChoice) {
		for(var _i = array_length(messageData) - 1; _i >= 0; _i--) {
			messageData[_i].blend(, max(1 + _fade, 0));
		}
	} else {
		messageData.blend(, max(1 + _fade, 0));
	}
}


if(multipleChoice) {
	for(var _i = array_length(messageData) - 1; _i >= 0; _i--) {
		messageData[_i].blend(c_white);
	}
	
	if(choiceHighlight != -1) {
		messageData[choiceHighlight].blend(c_yellow);
	}
}
	
var _tailXOff = clamp((originX - x) / (abs(originY - y) * .01 + 1), -bubbleWidth * .55, bubbleWidth * .55);
draw_set_color(c_black);
for(var _pointI = 3; _pointI < 6; _pointI++) {
	draw_circle(lerp(originX, x + _tailXOff, _pointI / 6), lerp(originY, y, _pointI / 6), _fadePortion * (_pointI * .5 + 2 + dsin((_pointI * 173 + current_time)) * .7), false);
}
draw_set_color(c_white);

gpu_set_ztestenable(false);

shader_set(shd_speechBubbleFog);

shader_set_uniform_f(shader_get_uniform(shd_speechBubbleFog, "time"), current_time / 1000);
shader_set_uniform_f(shader_get_uniform(shd_speechBubbleFog, "colorTint"), 1, 1, 0, 1);
shader_set_uniform_f(shader_get_uniform(shd_speechBubbleFog, "bubbleSize"), .6 * bubbleWidth / 512, .6 * bubbleHeight / 512);
shader_set_uniform_f(shader_get_uniform(shd_speechBubbleFog, "bubbleRadius"), point_distance(.6 * bubbleWidth / 512, .6 * bubbleHeight / 512, 0, 0));
shader_set_uniform_f(shader_get_uniform(shd_speechBubbleFog, "radiusBufferAdjust"), _fade);


var _bubbleSurf = getBubbleSurf();
draw_surface(_bubbleSurf, x - 256, y - 256);

shader_reset();

gpu_set_ztestenable(true);

if(createTime >= createTimeMax) {
	if(multipleChoice) {
		draw_circle(x, y - bubbleHeightFinal * .5, 5, true);
		
		var _dir = 90;
		var _dirAdd = 90;
		var _count = array_length(messageData);
		for(var _i = 0; _i < _count; _i++) {
			messageData[_i].draw(x + dcos(_dir) * 30, y - dsin(_dir) * 30); // how to use type writter with this?
			_dir += _dirAdd;
			_dirAdd += 90;
		}
	} else {
		messageData.draw(x, y - bubbleHeightFinal * .5, typewritter);
	}
}