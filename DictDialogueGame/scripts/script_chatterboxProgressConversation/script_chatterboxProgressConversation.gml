function script_chatterboxDialogueDoInteraction(speaker) {
	var _valid = false;
	if(dialoguePartner == speaker) {
		_valid = true;
		
		with(bubble) {
			if(!multipleChoice && typewritter.get_state() < 1) {
				typewritter.skip(); // skip text to end but don't delete or end bubble
				exit;
			}
		}
	} else if(!speaker.inDialogue) {
		script_chatterboxDialogueOpen(speaker);
		
		with(bubble) { // close any residual comments/bubbles now to start fresh
			duration = 0;
		}
		bubble = noone;
		
		_valid = true;
	}
	
	if(_valid) {				
		var _multi = false;
		var _choicesAlreadyChosen = undefined;
		var _choicesCriteriaResults = undefined;
		var _fadeDuration = 9999;
		if(text == -1) { // text being -1 means that a dialogue is not currently underway, the text is the current text being displayed, not the previous one.. 
			script_chatterboxDialogueStartMeeting(); // thus the -1 being start is saying, if no existing dialogue thread then start a new one..? Wack, better now that ive restructured yet again but still wack ngl
		} else {
			var _optionCount = ChatterboxGetOptionCount(chatterbox); // get options or lack thereof
			if(_optionCount != 0 && !emotionReactionsAvaialble) { // is multiple choice but not an emotion choice split
				if(!showingMultiOptions) { // first time passing this thing (aka the text shown is the intro line, not the options given after)
					showingMultiOptions = true; // toggle option vs dialogue (with options associated)
						
					var _info = ChatterboxGetOptionArray(chatterbox);
					var _count = array_length(_info);
					_choicesAlreadyChosen = array_create(_count);
					_choicesCriteriaResults = array_create(_count);
						
					text = array_create(_count);
					for(var _i = 0; _i < _count; _i++) { // populate this response with the options from the current last phrase, not the phrase itself (previous comment was lead in comment, next will be response to your option)
						text[_i] = _info[_i].text;
						//metadata[_i] = _info[_i].metadata;
						_choicesAlreadyChosen[_i] = ChatterboxGetOptionChosen(chatterbox, _i);
						_choicesCriteriaResults[_i] = ChatterboxGetOptionConditionBool(chatterbox, _i);
					}
						
					_multi = true;
				} else { // select from options
					showingMultiOptions = false; // toggle option vs dialogue (with options associated)
						
					var _choice = bubble.choiceHighlightOptionIndex;
					if(_choice != -1) {
						ChatterboxSelect(chatterbox, _choice);
					} else {
						exit; // no choosing without choosing!
					}
						
					script_chatterboxDialogueLoadTextStandard();
				}
			} else {
				if(emotionReactionsAvaialble) {
					// How do I skip an option??
					var _index = 0;
					if(keyboard_check_released(ord("7"))) { // happy
						_index = 1;
					} else if(keyboard_check_released(ord("8"))) { // angry
						_index = 2;
					} else if(keyboard_check_released(ord("9"))) { // sad
						_index = 3;
					}
					
					if(_index == 0) {
						ChatterboxSelect(chatterbox, 0); // when "skipping" a react option set simply choose the first option then jump to the next right away...? (this assumes nothing important lies in the first option... maybe make a dummy option?
						ChatterboxContinue(chatterbox);
					} else {
						ChatterboxSelect(chatterbox, _index); // choosing emotion to react with
					}
				} else {
					ChatterboxContinue(chatterbox);
				}
					
				if(ChatterboxIsStopped(chatterbox)) {
					text = -1;
					_fadeDuration = 150;
				} else {
					script_chatterboxDialogueLoadTextStandard();
				}
			}
		}
			
		#region metadata interpretation (of next line)
		var _textSpeed = 1;
		var _metadataCount = array_length(metadata);
		var _metadata = "";
			
		emotionReactionsAvaialble = false;
		var _recreateBubble = false;
			
		for(var _metaI = 0; _metaI < _metadataCount; _metaI++) {
			_metadata = metadata[_metaI];
				
			if(_metadata == "react") { // whether the comment can be reacted to with emotion reactions
				emotionReactionsAvaialble = true;
				instance_create_depth(x + irandom_range(-50, 50), y + irandom_range(-50, 50), -5000, obj_reactExclamation);
			} else if(_metadata == "newBubble") {
				_recreateBubble = true;
			} else if(_metadata == "monster") {
				//?
				_textSpeed = .44;
			} else if(_metadata == "human") {
				_textSpeed = .6;
			} else if(_metadata == "jap") {
				_textSpeed = 2;
			} else if(array_contains(["joke", "normal", "threat", "sarcasm", "plead", "insult"], _metadata)) { // the possible dialogue tags for the impact of the comment (replacing the concept of embedding influence values to comments) USE E_dialogueImpactTypes for reference
				script_dialogueInterpretCommentType(id, dialoguePartner, _metadata);
			}
		}
		#endregion
			
		if(text != -1) {
			var _bubbleExists = instance_exists(bubble);
			if(!_bubbleExists || _recreateBubble) {
				if(_bubbleExists) {
					bubble.duration = 0; // end previous bubble
				}
				
				msg(text);
				bubble = script_createSpeechBubble(id, bubbleType, x, y - 100, text, _fadeDuration, 20, _textSpeed, curve_SBemerge, curve_SBgrow, ,, _multi, _choicesAlreadyChosen, _choicesCriteriaResults);
			} else {          // this 0 is create delay, important if you're replacing the bubble.. Maybe I should make a proper re-apply script or something
				bubble.setState(text,,,,, 0, _textSpeed, 20, _multi, _choicesAlreadyChosen, _choicesCriteriaResults);
				bubble.textBegin();
			}
			dialogueValueCollection.totalDialogueLinesGiven++;
				
			optionChosenArrayDebug = _choicesAlreadyChosen;
			optionCriteriaArrayDebug = _choicesCriteriaResults;
		} else { // dialogue over?
			bubble.duration = 0; // text already ended so end bubble / close dialogue
			script_chatterboxDialogueClose();
		}
	}
}