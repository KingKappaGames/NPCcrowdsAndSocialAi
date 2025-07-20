if(keyboard_check(vk_enter)) {
	ChatterboxJump(chatterbox, "Start");
}

if(keyboard_check_released(vk_space) || mouse_check_button_released(mb_left)) {
	with(bubble) {
		if(!multipleChoice && typewritter.get_state() < 1) {
			typewritter.skip(); // skip text to end but don't delete or end bubble
			exit;
		} else {
			duration = 0; // text already ended so end bubble / close dialogue (and continue if applicable)
		}
	}
	
	var _multi = false;
	var _choicesAlreadyChosen = undefined;
	var _choicesCriteriaResults = undefined;
	var _fadeDuration = 9999;
	if(text == -1) {
		if(dialogueValueCollection.firstMet == 0) {
			ChatterboxJump(chatterbox, "Start");
		} else {
			var _timesMet = dialogueValueCollection.timesMet;
			if(_timesMet == 3) {
				if(dialogueValueCollection.secretTold) {
					ChatterboxJump(chatterbox, "Friend");
				} else {
					ChatterboxJump(chatterbox, "LeaveMeAlone");
				}
			} else if(_timesMet > 3) {
				exit; // no talking (testing whether canceling dialogue interaction works
			} else if(_timesMet < 3) {
				if(!dialogueValueCollection.secretTold || irandom(1) == 0) {
					ChatterboxJump(chatterbox, "Next");
				} else {
					ChatterboxJump(chatterbox, "Secret");
				}
			}
		}
		
		text = ChatterboxGetContent(chatterbox, 0);
		metadata = ChatterboxGetContentMetadata(chatterbox, 0);
		
		dialogueValueCollection.timesMet++;
		dialogueValueCollection.firstMet = true;
	} else {
		
		var _optionCount = ChatterboxGetOptionCount(chatterbox);
		if(_optionCount != 0) {
			if(text == ChatterboxGetContent(chatterbox, 0)) { // first time passing this thing (aka the text shown is the intro line, not the options given after)
				var _info = ChatterboxGetOptionArray(chatterbox);
				var _count = array_length(_info);
				_choicesAlreadyChosen = array_create(_count);
				_choicesCriteriaResults = array_create(_count);
				
				text = array_create(_count);
				for(var _i = 0; _i < _count; _i++) { // populate this response with the options from the current last phrase, not the phrase itself (previous comment was lead in comment, next will be response to your option)
					text[_i] = _info[_i].text;
					_choicesAlreadyChosen[_i] = ChatterboxGetOptionChosen(chatterbox, _i);
					_choicesCriteriaResults[_i] = ChatterboxGetOptionConditionBool(chatterbox, _i);
				}
					
				_multi = true;
			} else {
				var _choice = bubble.choiceHighlightOptionIndex;
				if(_choice != -1) {
					ChatterboxSelect(chatterbox, _choice);
				} else {
					ChatterboxSelect(chatterbox, irandom(_optionCount - 1));
				}
				
				text = ChatterboxGetContent(chatterbox, 0);
				metadata = ChatterboxGetContentMetadata(chatterbox, 0);
			}
		} else {
			ChatterboxContinue(chatterbox);
			
			if(ChatterboxIsStopped(chatterbox)) {
				text = -1;
				_fadeDuration = 90;
			} else {
				text = ChatterboxGetContent(chatterbox, 0);
				metadata = ChatterboxGetContentMetadata(chatterbox, 0);
			}
		}
	}
	
	var _textSpeed = 1;
	if(array_length(metadata) != 0) {
		var _metadata = metadata[0];
		if(_metadata == "monster") {
			//?
			_textSpeed = .44;
		} else if(_metadata == "human") {
			_textSpeed = .6;
		} else if(_metadata == "jap") {
			_textSpeed = 2;
		}
	}
	
	if(text != -1) {
		bubble = script_createSpeechBubble(x, y - 100, text, _fadeDuration, 20, _textSpeed, curve_SBemerge, curve_SBgrow,,, _multi, _choicesAlreadyChosen, _choicesCriteriaResults);
		dialogueValueCollection.totalDialogueLinesGiven++;
		optionChosenArrayDebug = _choicesAlreadyChosen;
		optionCriteriaArrayDebug = _choicesCriteriaResults;
	}
};