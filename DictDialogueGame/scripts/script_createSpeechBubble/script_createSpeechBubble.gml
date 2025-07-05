function script_createSpeechBubble(xx, yy, messageText, durationSet, createDelay, textSpeed, posCurve, sizeCurve, arrowOriginX = x, arrowOriginY = y - (sprite_height / 2) - 25, multipleChoiceSet = false){
	var _bubble = instance_create_layer(arrowOriginX, arrowOriginY, "Instances", obj_speechBubble);
	_bubble.sourceId = id; // guess the caller
	
	_bubble.originX = arrowOriginX;
	_bubble.originY = arrowOriginY;
	
	var _textLength = string_length(messageText);
	_bubble.duration = durationSet + _textLength / textSpeed;
	
	_bubble.setState(messageText, posCurve, sizeCurve, xx - arrowOriginX, yy - arrowOriginY, createDelay, textSpeed, 20, multipleChoiceSet);
	
	return _bubble;
}