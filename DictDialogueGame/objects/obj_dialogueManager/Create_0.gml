if(live_call()) { return live_result }

randomize();

dialogueNpcCurrent = noone;
dialogueValid = false;

dialogueString = "";
responseString = "";
previousDialogueString = "";

dialogueDictionary = ds_grid_create(17, 2); // REMEMBER TO INCREMENT

#region dialogue entries script_answerName
ds_grid_set(dialogueDictionary, 16, 0, "what is your name");
ds_grid_set(dialogueDictionary, 16, 1, [script_answerName, 1]); // what are the values for response choosing specifically?

ds_grid_set(dialogueDictionary, 15, 0, "are you ready to die");
ds_grid_set(dialogueDictionary, 15, 1, [["What?!", .5], ["Murderer!", .5]]); // what are the values for response choosing specifically?

ds_grid_set(dialogueDictionary, 14, 0, "are you poor");
ds_grid_set(dialogueDictionary, 14, 1, [[script_answerStatus, .6], ["That's not very nice...", .3]]); // what are the values for response choosing specifically?

ds_grid_set(dialogueDictionary, 13, 0, "are you rich");
ds_grid_set(dialogueDictionary, 13, 1, [[script_answerStatus, .65], ["Do I look it?", .24], ["Hah!", .1]]); // what are the values for response choosing specifically?

ds_grid_set(dialogueDictionary, 12, 0, "are you single");
ds_grid_set(dialogueDictionary, 12, 1, [[script_answerRomanticPartner, .9], ["Wow!", .1]]); // what are the values for response choosing specifically?

ds_grid_set(dialogueDictionary, 11, 0, "do you support the lord");
ds_grid_set(dialogueDictionary, 11, 1, [["Sure, I've no problems. Why do you ask?", .5], ["It doesn't matter, as long as he does his job he's just fine.", .5]]); // what are the values for response choosing specifically?
		
ds_grid_set(dialogueDictionary, 10, 0, "do you know magic");
ds_grid_set(dialogueDictionary, 10, 1, [[script_answerMagic, .5], ["No, of course not. Why do you ask?", .5], ["There's no witches here, if that's your meaning.", .5]]); // what are the values for response choosing specifically?
		
ds_grid_set(dialogueDictionary, 9, 0, "how old are you");
ds_grid_set(dialogueDictionary, 9, 1, [["You shouldn't ask people that.", 1], ["Rude...", .5], [script_answerAge, .5]]); // add array positions for different possible responses depending on fear or unwillingness to say... Perhaps generic "im too anxious to talk about that right now" or "I'm not going to tell you that." Mixed with specific comments like, "Never ask a woman her age." for age questions specifically. Any place with out a custom remark would be auto filled with a standard "I don't talk about that" kidn of thing.
		
ds_grid_set(dialogueDictionary, 8, 0, "do you work in the city");
ds_grid_set(dialogueDictionary, 8, 1, [["No, not since the collapse. Nice place though, people are doing their best out there.", 1]]);
		
ds_grid_set(dialogueDictionary, 7, 0, "how are you");
ds_grid_set(dialogueDictionary, 7, 1, [["I'm fine, thanks.", .5], [script_answerMood, .5]]);
	
ds_grid_set(dialogueDictionary, 6, 0, "are you married");
ds_grid_set(dialogueDictionary, 6, 1, [["Yes, but I'm not going to talk about it anymore.", 1]]);

ds_grid_set(dialogueDictionary, 5, 0, "who are you");
ds_grid_set(dialogueDictionary, 5, 1, [[script_answerName, 1]]);
		
ds_grid_set(dialogueDictionary, 4, 0, "where do you live");
ds_grid_set(dialogueDictionary, 4, 1, [["I'm not telling you that. You shouldn't ask.", 1]]);
		
ds_grid_set(dialogueDictionary, 3, 0, "what are you doing");
ds_grid_set(dialogueDictionary, 3, 1, [[script_answerAction, .5]]);
		
ds_grid_set(dialogueDictionary, 2, 0, "when did you move to skyrim");
ds_grid_set(dialogueDictionary, 2, 1, [["Back when I was a kid, are you going to pester me like the imperials?", 1]]);
		
ds_grid_set(dialogueDictionary, 1, 0, "why did you become an npc");
ds_grid_set(dialogueDictionary, 1, 1, [["That's.. what does that mean?", 1]]);
		
ds_grid_set(dialogueDictionary, 0, 0, "how do you like it here");
ds_grid_set(dialogueDictionary, 0, 1, [["It's fine, too much grass around here if you ask me.", .5], ["Fair enough, nothing else to say.", .5]]);

#endregion

startDialogue = function(dialogueNpcCurrentSet) {
	live_auto_call
	dialogueNpcCurrent = dialogueNpcCurrentSet;
	
	x = dialogueNpcCurrent.x;
	y = dialogueNpcCurrent.y - 40;
}

endDialogue = function() {
	live_auto_call
	dialogueNpcCurrent = noone;
	dialogueString = "";
	dialogueValid = false;
}

parseDialogue = function(enterDialogue = false) {
	live_auto_call
	var _entryPos = ds_grid_value_x(dialogueDictionary, 0, 0, ds_grid_width(dialogueDictionary) - 1, 0, dialogueString);
	//show_debug_message("hit " + string(_entryPos))
	if(_entryPos != -1) {
		dialogueValid = 1;
	} else {
		dialogueValid = 0;
	}
	
	if(enterDialogue) {
		if(_entryPos != -1) {
			decideResponseFromSet(_entryPos, 1);
			dialogueValid = true;
		} else {
			dialogueValid = false;
		}
		previousDialogueString = dialogueString;
		dialogueString = "";
	}
}

decideResponseFromSet = function(gridX, gridY = 1) {
	live_auto_call
	responseString = "No! (default)";
	
	var _responseData = ds_grid_get(dialogueDictionary, gridX, gridY); // all possible responses with criteria for each
	var _validResponses = [];
	var _validCount = 0;
	
	if(is_array(_responseData[0])) {
		for(var _criteriaCheckI = array_length(_responseData) - 1; _criteriaCheckI > -1; _criteriaCheckI--) { // figure out which responses can't be used do to criteria and add the valid ones to valid responses []
			//if(_responseData[_criteriaCheckI][which pos(s) to check?] > npcFear or npcTrust or npcDrunkeness) { // success criteria based on values and checks
				array_push(_validResponses, _responseData[_criteriaCheckI]); //success
				_validCount++;
			//}
		}
	} else {
		_validResponses[0] = _responseData;
		_validCount = 1;
	}
	
	msg("Valid count: " + string(_validCount));
	
	if(_validCount > 0) {
		if(_validCount == 1) { // only one response which also means you don't have to do the random choosing (only one means no choosing you know?..)
			if(is_string(_validResponses[0][0])) {
				responseString = _validResponses[0][0];
			} else if(typeof(_validResponses[0][0]) == "ref") {
				responseString = _validResponses[0][0](dialogueNpcCurrent);
			}
		} else { // more than one working option, choose random
			var _randTotal = 0; //grab random from collection of possible
			for(var _randCountUpI = array_length(_validResponses) - 1; _randCountUpI > -1; _randCountUpI--) {
				_randTotal += _validResponses[_randCountUpI][1]; // the random chance component
			} // add up random weights
			
			msg("Rand total added: " + string(_randTotal));
			_randTotal = random(_randTotal); // randomly pick a point within the range to be the result
			msg($"Random point chosen {_randTotal}");
			
			for(var _randDecayI = array_length(_validResponses) - 1; _randDecayI > -1; _randDecayI--) {
				_randTotal -= _validResponses[_randDecayI][1]; // the random chance component
				if(_randTotal <= 0) {
					msg("Response chosen index: " + string(_randDecayI));
					if(is_string(_validResponses[_randDecayI][0])) {
						responseString = _validResponses[_randDecayI][0];
					} else if(typeof(_validResponses[_randDecayI][0]) == "ref") {
						responseString = _validResponses[_randDecayI][0](dialogueNpcCurrent);
					}
					break;
				}
			} // cut down the random until it "lands" on a result
		}
	} // if it has no valids (which shouldn't ever happen for the record...) then it'll say the default string above.
}