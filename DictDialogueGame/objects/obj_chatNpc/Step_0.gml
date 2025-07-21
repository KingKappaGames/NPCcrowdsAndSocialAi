if(instance_exists(speakerId)) {
	if(point_distance(speakerId.x, speakerId.y, x, y) > 100) { // close if speaker too far away
		speakerId.inDialogue = false;
		speakerId = noone;
		if(instance_exists(bubble)) {
			bubble.duration = 0;
		}
		text = -1;
	}
} else {
	if(text != -1) {
		text = -1;
		speakerId.inDialogue = false;
		speakerId = noone;
		if(instance_exists(bubble)) {
			bubble.duration = 0;
		}
	}
}

if(keyboard_check_released(vk_space) || mouse_check_button_released(mb_left)) {
	if(point_distance(x, y, global.player.x, global.player.y) < interactionRange) { // only player can really start a dialogue this way..
		if(speakerId == global.player || !global.player.inDialogue) { // not already in a dialogue
			speakerId = global.player;
			speakerId.inDialogue = true; // TODO I really need an entry and exit script for dialogues to do all the clean up and set up in one place!
			
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
				getDialogueResponse(); // sets the chatterbox node, mostly
				
				text = ChatterboxGetContent(chatterbox, 0);
				metadata = ChatterboxGetContentMetadata(chatterbox, 0); // get info from node
				
				dialogueValueCollection.timesMet++;
				dialogueValueCollection.firstMet = true; // do standard dialogue book keeping
			} else {
				
				var _optionCount = ChatterboxGetOptionCount(chatterbox); // get options or lack thereof
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
			
			#region metadata interpretation
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
			#endregion
			
			if(text != -1) {
				bubble = script_createSpeechBubble(id, bubbleType, x, y - 100, text, _fadeDuration, 20, _textSpeed, curve_SBemerge, curve_SBgrow, ,, _multi, _choicesAlreadyChosen, _choicesCriteriaResults);
				dialogueValueCollection.totalDialogueLinesGiven++;
				
				optionChosenArrayDebug = _choicesAlreadyChosen;
				optionCriteriaArrayDebug = _choicesCriteriaResults;
			} else { // dialogue over?
				speakerId.inDialogue = false;
				speakerId = noone;
			}
		}
	}
};