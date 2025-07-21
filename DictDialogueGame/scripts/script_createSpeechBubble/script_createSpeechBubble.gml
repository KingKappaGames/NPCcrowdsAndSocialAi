/// @desc Function Creates a speech bubble with position, visual, and text properties
/// @param {any*} source The id of the thing that owns this bubble, so pass the npc that says it or I suppose a non owned or executive bubble is possible too
/// @param {any*} bubbleTypeSet The "style" of the bubble as a string, for now just "shadow" for a dark warbly bubble but adding more hopefully
/// @param {any*} xx The center x of the finished bubble
/// @param {any*} yy The center y of the finished bubble
/// @param {any*} messageText The text of the bubble OR an array of text if you're doing multiple choice
/// @param {any*} durationSet How long to stay as a full bubble (not including the length of writing the text, so the actual duration would be text writing time plus this)
/// @param {any*} createDelay How many frames to go from nothing to fully formed bubble but not including the text writing 
/// @param {any*} textSpeed How many characters should be added to the text per frame, ergo .25 would show 15 characters per second
/// @param {any*} posCurve The anim curve to use for moving from inital to final x when being formed (assumes two channels "x" and "y")
/// @param {any*} sizeCurve The anim curve to use for growing the bubble when being formed (assumes two channels "width" and "height")
/// @param {any*} [arrowOriginX]=x The origin of the bubble on it's path and the tail tip X
/// @param {any*} [arrowOriginY]=y - (sprite_height / 2) - 25 The origin of the bubble on its path and the tail tip Y
/// @param {any*} [multipleChoiceSet]=false  Whether this speech bubble should be displaying a multiple choice option set rather than spoken dialogue
/// @param {any*} [optionsChosenArraySet]=-1 Array of whether the option in this multiple choice dialogue have already been chosen/followed (how many times actually)
/// @param {any*} [optionsCriteriaArraySet]=-1 Array of whether the criteria for the options in a multiple choice dialogue were true or false, any that were fale will be removed from the bubble
function script_createSpeechBubble(source, bubbleTypeSet, xx, yy, messageText, durationSet, createDelay, textSpeed, posCurve, sizeCurve, arrowOriginX = source.x, arrowOriginY = source.y - (source.sprite_height / 2) - 25, multipleChoiceSet = false, optionsChosenArraySet = -1, optionsCriteriaArraySet = -1){
	var _bubble = instance_create_layer(arrowOriginX, arrowOriginY, "Instances", obj_speechBubble);
	_bubble.sourceId = source; // guess the caller
	_bubble.bubbleType = bubbleTypeSet;
	
	if(bubbleTypeSet == "shadow") {
		_bubble.bubbleTextColor = c_white;
		_bubble.bubbleTextColorHighlight = c_yellow;
	} else if(bubbleTypeSet == "white") {
		_bubble.bubbleTextColor = #280000;
		_bubble.bubbleTextColorHighlight = #5f1a00;
	}
	
	_bubble.originX = arrowOriginX;
	_bubble.originY = arrowOriginY;
	
	var _textLength = string_length(messageText);
	_bubble.duration = durationSet + _textLength / textSpeed;
	
	_bubble.setState(messageText, posCurve, sizeCurve, xx - arrowOriginX, yy - arrowOriginY, createDelay, textSpeed, 20, multipleChoiceSet, optionsChosenArraySet, optionsCriteriaArraySet);
	
	return _bubble;
}