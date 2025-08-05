chatterbox = noone;

speakerId = noone; // the OTHER person in this dialogue, not me!

text = -1;
metadata = -1;

bubble = noone;
bubbleType = choose("shadow", "white");

dialogueValueCollection = noone;

interactionRange = 50;

showingMultiOptions = false; // whether you're showing the dialogue that prompts a multi response or the responses themselves
emotionReactionsAvaialble = false;

optionChosenArrayDebug = -1;
optionCriteriaArrayDebug = -1;

/// @desc Function Jumps to the next node based on the conditions and tree of this npcs dialogue, then the frame of the dialogue grabs that info and creates comments with it
getDialogueResponse = function() {
	//overwritten by the specific npc
}

///@desc Simply loads some values from the inital comment, but perhaps can be useful for other first comment things too?
dialogueStartFirstMeeting = function() {
	getDialogueResponse(); // sets the chatterbox node, mostly
				
	dialogueLoadTextStandard(); // sets the data from this line
				
	dialogueValueCollection.timesMet++; // other data
	dialogueValueCollection.firstMet = true; // do standard dialogue book keeping
}

///@desc Just loads the text and other data from the current node and line of dialogue that is known to be a standard comment, not a multiple choice
dialogueLoadTextStandard = function() {
	text = ChatterboxGetContent(chatterbox, 0);
	metadata = ChatterboxGetContentMetadata(chatterbox, 0); // get info from node
}

///@desc For now just delinks the speaker and npc, aka, unsets their speakerId and inDialogue values
dialogueClose = function() {
	speakerId.inDialogue = false;
	speakerId = noone;
}

///@desc For now just links the speaker and npc, aka, sets their speakerId and inDialogue values
dialogueOpen = function(speaker) {
	speakerId = speaker;
	speakerId.inDialogue = true; // TODO I really need an entry and exit script for dialogues to do all the clean up and set up in one place!
}

dialogueShutdownChat = function() {
	text = -1;
	speakerId.inDialogue = false;
	speakerId = noone;
	if(instance_exists(bubble)) {
		bubble.duration = 0;
	}	
}

dialogueDoInteraction = function(speaker) {
	if(speakerId == speaker || !speaker.inDialogue) { // not already in a dialogue
		dialogueOpen(speaker);
			
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
			dialogueStartFirstMeeting();
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
						
					dialogueLoadTextStandard();
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
					_fadeDuration = 90;
				} else {
					dialogueLoadTextStandard();
				}
			}
		}
			
		#region metadata interpretation (of next line)
		var _textSpeed = 1;
		var _metadataCount = array_length(metadata);
		var _metadata = "";
			
		emotionReactionsAvaialble = false;
			
		for(var _metaI = 0; _metaI < _metadataCount; _metaI++) {
			_metadata = metadata[_metaI];
				
			if(_metadata == "react") { // whether the comment can be reacted to with emotion reactions
				emotionReactionsAvaialble = true;
				instance_create_depth(x + irandom_range(-50, 50), y + irandom_range(-50, 50), -5000, obj_reactExclamation);
			} else if(_metadata == "monster") {
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
			dialogueClose();
		}
	}
}
