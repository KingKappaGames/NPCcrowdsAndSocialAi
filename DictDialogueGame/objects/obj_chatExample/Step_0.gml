if(keyboard_check(vk_enter)) {
	if(irandom(1) == 0) {
		ChatterboxJump(chatterbox, "Next");
	} else {
		ChatterboxJump(chatterbox, "Start");
	}
	dialoguePosition = 0;
	text = -1;
}

if(keyboard_check_released(vk_space)) {
	if(instance_exists(bubble)) {
		bubble.duration = 0;
	}
	
	var _multi = false;
	var _fadeDuration = 9999;
	if(text == -1) {
		text = ChatterboxGetContent(chatterbox, 0);
	} else {
		
		var _optionCount = ChatterboxGetOptionCount(chatterbox);
		show_debug_message(_optionCount);
		if(_optionCount != 0) {
			if(text == ChatterboxGetContent(chatterbox, 0)) { // first time passing this thing (aka the text shown is the intro line, not the options given after)
				var _info = ChatterboxGetOptionArray(chatterbox);
				var _count = array_length(_info);
				text = array_create(_count);
				for(var _i = 0; _i < _count; _i++) { // populate this response with the options from the current last phrase, not the phrase itself (previous comment was lead in comment, next will be response to your option)
					text[_i] = _info[_i].text;
				}
					
				_multi = true;
			} else {
				var _choice = bubble.choiceHighlight;
				if(_choice != -1) {
					ChatterboxSelect(chatterbox, _choice);
				} else {
					ChatterboxSelect(chatterbox, irandom(_optionCount - 1));
				}
				
				text = ChatterboxGetContent(chatterbox, 0);
			}
		} else {
			ChatterboxContinue(chatterbox);
			
			if(ChatterboxIsStopped(chatterbox)) {
				text = "Dialogue over";
				_fadeDuration = 90;
			} else {
				text = ChatterboxGetContent(chatterbox, 0);
			}
		}
	}
		
	bubble = script_createSpeechBubble(x, y - 100, text, _fadeDuration, 20, 3, curve_SBemerge, curve_SBgrow,,, _multi);
	//dialoguePosition++;
		
	
};