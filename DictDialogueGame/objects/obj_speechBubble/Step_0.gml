if(keyboard_check(ord("1"))) {
	choiceHighlight = 0;
} else if(keyboard_check(ord("2"))) {
	choiceHighlight = 1;
} else if(keyboard_check(ord("3"))) {
	choiceHighlight = 2;
} else if(keyboard_check(ord("4"))) {
	choiceHighlight = 3;
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
	}
}