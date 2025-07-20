depth = -5000;

duration = 120;

fadeTime = 0;
fadeTimeMax = 20;

createTime = 0;
createTimeMax = 20;

sourceId = noone;

originX = 0;
originY = 0;

textSpeed = 1;

distScaleX = 20;
distScaleY = 20;

xCurve = -1;
yCurve = -1;
widthCurve = -1;
heightCurve = -1;

bubbleWidth = 0;
bubbleHeight = 0;

bubbleWidthFinal = 0;
bubbleHeightFinal = 0; // the width/height curves should both range from 0-1 or over 1, they should both end at 1, the multiplier of goalW/H then multiplies with the "scales" from those curves

bubbleSurf = -1;
bubbleTextSurf = -1; // use surfaces to store the speech bubbles (especially easy when not in growth period) and use these surfaces to apply shaders and whatnot

multipleChoice = false;

choiceAngles = [90, 180, 0, 270]; // four options at top, left, right, bottom

choiceHighlight = -1; // the option in the speech bubble that is being highlighted (will be different than the option index highlight if any options have been removed below thus shifting the index)
choiceHighlightOptionIndex = -1; // the option index in chatterbox that is being highlighted

choiceCriteriaArray = -1;

choiceChosenArray = -1;
choiceTextIndexArray = -1;

choiceArrowDirection = 90;

getBubbleSurf = function() {
	if(!surface_exists(bubbleSurf)) {
		bubbleSurf = surface_create(512, 512); // bit big?
		surface_set_target(bubbleSurf);
		draw_clear(c_black);
		surface_reset_target();
	}
	return bubbleSurf;
}

//messeageText = ""; // does the scribble struct contain the text or just the shape?
messageData = scribble(""); // the "text" baked in scribble format
typewritter = scribble_typist(); // the type writter effect for scribble
typewritter.character_delay_add(".", 400); // hopefully adds a 1 second delay every period that is found
optionData = -1;


/// @desc sets the default values for a potential speech bubble, beyond the basic use for one line or another (sets intro and outro among other things)
/// @param {any*} textString The text to show in the bubble, including scribble formatting
/// @param {any*} positionCurve The curve to use as character for the spawn path (curve ranges 0-1 for output)
/// @param {any*} sizeCurve The curve to use as the guide for how big the speech bubble should be as it's forming
/// @param {any*} [distanceScaleX]=20 The horizontal scale of the dist curve
/// @param {any*} [distanceScaleY]=20 The vertical scale of the dist curve
/// @param {any*} [createDelay]=35 How many frames to take while spawning in and growing the text bubble
/// @param {any*} [typeSpeed]=.2 How many characters per frame to add
/// @param {any*} [fadeDelay]=30 How many frames to take to remove the speech bubble, while it shrinks and fades out
/// @param {any*} [multipleChoice]=false Whether or not this speech bubble is a choose your own option multi bubble, showing the options, not the response text
/// @param {any*} [choiceSeenArraySet]=-1 If this is an option set this will pass the options that have already been chosen (array of options as bools of chosen_before) before in the game (or in this chatterbox instance at least?)
/// @param {any*} [choiceCriteriaArraySet]=-1 If this is a multiple choice set then this array contains the result booleans of each entries criteria (or multiple) including optionally the question of whether it's been selected before (depends on the chatterscript side)
setState = function(textString, positionCurve, sizeCurve, distanceScaleX = 20, distanceScaleY = 20, createDelay = 35, typeSpeed = .2, fadeDelay = 30, multipleChoiceSet = false, choiceSeenArraySet = -1, choiceCriteriaArraySet = -1) {
	live_auto_call
	
	multipleChoice = multipleChoiceSet;
	choiceChosenArray = choiceSeenArraySet;
	
	if(multipleChoice) {
		
		var _initialOptionLength = array_length(textString);
		choiceTextIndexArray = array_create(_initialOptionLength); // asign each text option in the multi choice to a resulting choice index that will be returned when you select it
		var _choiceIndex = 0;
		repeat(_initialOptionLength) {
			choiceTextIndexArray[_choiceIndex] = _choiceIndex;
			_choiceIndex++;
		}
		
		if(choiceCriteriaArraySet != -1) {
			for(var _cullI = array_length(choiceCriteriaArraySet) - 1; _cullI >= 0; _cullI--) { // remove options that don't pass criteria
				if(choiceCriteriaArraySet[_cullI] == 0) {
					array_delete(textString, _cullI, 1);
					array_delete(choiceTextIndexArray, _cullI, 1); // cull both the option and the index it relates to from the net option data arrays
					array_delete(choiceSeenArraySet, _cullI, 1);
				}
			}
		}
		
		var _optionCount = array_length(textString);
		
		var _alignments = 0;
		if(_optionCount == 1) {
			_alignments = [fa_center];
		} else if(_optionCount == 2) {
			_alignments = [fa_right, fa_left];
		} else if(_optionCount == 3) {
			_alignments = [fa_center, fa_right, fa_left];
		} else if(_optionCount == 4) {
			_alignments = [fa_center, fa_right, fa_left, fa_center];
		}
		
		for(var _i = _optionCount - 1; _i >= 0; _i--) {
			messageData[_i] = scribble(textString[_i]);
			messageData[_i].wrap(256);
			
			messageData[_i].align(_alignments[_i], fa_middle);
		}
		
		var _textBoxLeft = 0;
		var _textBoxRight = 0;
		
		if(_optionCount == 1) { // left right
			var _textBoxTop = messageData[0].get_bbox();
			
			bubbleWidthFinal = _textBoxTop.width + 70;
			bubbleHeightFinal = _textBoxTop.height + 100;
			
			choiceAngles = [90];
		} else if(_optionCount == 2) { // left right
			_textBoxLeft = messageData[0].get_bbox();
			_textBoxRight = messageData[1].get_bbox();
			
			bubbleWidthFinal = _textBoxLeft.width + _textBoxRight.width + 100;
			bubbleHeightFinal = _textBoxRight.height * 2 + 100;
			
			choiceAngles = [180, 0];
		} else if(_optionCount == 3) { // top left right
			_textBoxLeft = messageData[1].get_bbox();
			_textBoxRight = messageData[2].get_bbox();
			
			bubbleWidthFinal = _textBoxLeft.width + _textBoxRight.width + 100;
			bubbleHeightFinal = _textBoxRight.height * 2 + 100;
			
			choiceAngles = [90, 180, 0];
		} else if(_optionCount == 4) { // top left bottom right
			_textBoxLeft = messageData[1].get_bbox();
			_textBoxRight = messageData[3].get_bbox();
			
			bubbleWidthFinal = _textBoxLeft.width + _textBoxRight.width + 100;
			bubbleHeightFinal = _textBoxRight.height * 2 + 100;
			
			choiceAngles = [90, 180, 0, 270];
		}
	} else {
		messageData = scribble(textString);
		
		messageData.wrap(256);
		messageData.align(fa_center, fa_middle);
		
		var _textBbox = messageData.get_bbox(); // the border of the text
		bubbleWidthFinal = _textBbox.width + 72; // scribble get width of baked text
		bubbleHeightFinal = _textBbox.height + 48; // scribble get width of baked text
	}
	
	distScaleX = distanceScaleX;
	distScaleY = distanceScaleY;
	
	xCurve = animcurve_get_channel(positionCurve, "x");
	yCurve = animcurve_get_channel(positionCurve, "y");
	widthCurve = animcurve_get_channel(sizeCurve, "width");
	heightCurve = animcurve_get_channel(sizeCurve, "height");
	
	bubbleWidth = 1;
	bubbleHeight = 1;
	
	textSpeed = typeSpeed;
	
	createTime = 0;
	createTimeMax = createDelay;
	
	fadeTime = 0;
	fadeTimeMax = fadeDelay;
}

textBegin = function(writeSpeed = textSpeed) {
	typewritter.reset();
	typewritter.in(writeSpeed, .5);
}


//I'm thinking the sequence would be, spawn as a small bubble at the character or their head, float along the curve path according to createTime/createTimeMax
//grow the bubble while it follows this path but don't put words in it (right?), use curves to give the pathing and bubble engargening a nice "juice"
//then once the bubble has hit the end of the path start adding the text to it via scribble
//for continuations you could either fade all the old text out and start resizing the bubble to fit the next bit of text (which would be type written out in the same space as this happens)
//or you could have the tail sever and the bubble disperse to create a new bubble, though I think that would be too jarring, to have the speech bubbles constantly fly off and reforming
//but at the end it would work, have the tail disintegrate and the speech bubble fades away somehow, each of the parts would have effects and movement curves and stuff to make them feel better

//shader to create gassy, foggy edges but black centers to the bubbles, perhaps chroma mixed edges and faint lighted cloud like swirls along the edges too