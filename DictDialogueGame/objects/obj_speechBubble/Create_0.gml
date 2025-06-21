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

setState = function(textString, positionCurve, sizeCurve, distanceScaleX = 20, distanceScaleY = 20, createDelay = 35, typeSpeed = .2, fadeDelay = 30) {
	messageData = scribble(textString);
	
	distScaleX = distanceScaleX;
	distScaleY = distanceScaleY;
	
	var _textBbox = messageData.get_bbox(); // the border of the text
	bubbleWidthFinal = _textBbox.width; // scribble get width of baked text
	bubbleHeightFinal = _textBbox.height; // scribble get width of baked text
	
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

textBegin = function(speed = textSpeed) {
	typewritter.reset();
	typewritter.in(speed, .5);
}


//I'm thinking the sequence would be, spawn as a small bubble at the character or their head, float along the curve path according to createTime/createTimeMax
//grow the bubble while it follows this path but don't put words in it (right?), use curves to give the pathing and bubble engargening a nice "juice"
//then once the bubble has hit the end of the path start adding the text to it via scribble
//for continuations you could either fade all the old text out and start resizing the bubble to fit the next bit of text (which would be type written out in the same space as this happens)
//or you could have the tail sever and the bubble disperse to create a new bubble, though I think that would be too jarring, to have the speech bubbles constantly fly off and reforming
//but at the end it would work, have the tail disintegrate and the speech bubble fades away somehow, each of the parts would have effects and movement curves and stuff to make them feel better

//shader to create gassy, foggy edges but black centers to the bubbles, perhaps chroma mixed edges and faint lighted cloud like swirls along the edges too