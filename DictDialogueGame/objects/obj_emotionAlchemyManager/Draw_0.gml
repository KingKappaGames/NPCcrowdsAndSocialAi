if(live_call()) { return live_result }

var _drawAngle = 0;
var _drawDist = 40;
var _drawColor = c_white;
for(var _i = 0; _i < emotionCount; _i++) {
	_drawDist = 40 + emotionImpacts[_i] * 15;
	_drawColor = merge_color(emotionColors[_i], c_grey, abs(.5 - emotionStates[_i]) * 2);
	draw_circle_color(x + dcos(_drawAngle) * _drawDist, y - dsin(_drawAngle) * _drawDist, 10 - emotionImpacts[_i] * 5, _drawColor, _drawColor, false);
	
	_drawAngle += 360 / emotionCount;
}