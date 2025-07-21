if(multipleChoice) {
	if(keyboard_check(ord("1"))) {
		choiceHighlight = 0;
	} else if(keyboard_check(ord("2"))) {
		choiceHighlight = 1;
	} else if(keyboard_check(ord("3"))) {
		choiceHighlight = 2;
	} else if(keyboard_check(ord("4"))) {
		choiceHighlight = 3;
	}
	
	if(choiceHighlight >= array_length(messageData)) {
		choiceHighlight = -1;
	}
}
	

if(createTime < createTimeMax) { // not yet fully created
	createTime++;
	
	var _createProgress = createTime / createTimeMax;
	x = originX + animcurve_channel_evaluate(xCurve, _createProgress) * distScaleX;
	y = originY + animcurve_channel_evaluate(yCurve, _createProgress) * distScaleY;
	bubbleWidth = animcurve_channel_evaluate(widthCurve, _createProgress) * bubbleWidthFinal;
	bubbleHeight = animcurve_channel_evaluate(heightCurve, _createProgress) * bubbleHeightFinal;
	
	if(createTime == createTimeMax) {
		textBegin();
	}
} else {
	duration--;
	if(duration <= 0) {
		if(fadeTime < fadeTimeMax) {
			fadeTime++;
		} else {
			instance_destroy();
		}
	} else { // still current and all that
		var _dir = 0;
		var _count = array_length(messageData);
		for(var _i = 0; _i < _count; _i++) {
			_dir = choiceAngles[_i];
			var _bbox = messageData[_i].get_bbox(x + dcos(_dir) * 32, y - dsin(_dir) * 28);
			if(point_in_rectangle(mouse_x, mouse_y, _bbox.left - 5, _bbox.top - 5, _bbox.right + 5, _bbox.bottom + 5)) {
				choiceHighlight = _i;
				choiceHighlightOptionIndex = choiceTextIndexArray[_i];
				break;
			}
		}
	}
}