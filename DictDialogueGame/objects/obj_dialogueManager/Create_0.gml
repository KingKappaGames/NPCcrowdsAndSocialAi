if(live_call()) { return live_result }

randomize();

speakerId = noone;
speakerOtherId = noone; // does nothing for now since i think player will be the only one to use this, obviously the typing part but maybe the data fetching?

dialogueValid = false;
dialogueString = "";
responseString = "";
previousDialogueString = "";
previousDialogueLineNpc = noone;

bubble = noone;

// I think all the "fixed" lines like story dialogues, info text, and random comments should be within the chatterbox world. These would be the easiest to write there
// and don't require much if any dynamic change, since they'll only be seen once for story stuff or maybe contain certain bits that change for random comments, or the 
// comment itself will change, since that's what skyrim does, just have a bunch of lines for variety. 
// however the dict dialogue stuff must be in code, the entire response is constructed out of pieces and woven out of script calls. There's no way, at least for me
// to comfortably build such a system in chatterbox and I don't see why I would try. They can both use the same dialogue result but the text can come from different places
// I think this would be best and keep everything that's more rigid in chatterbox. You may even embed certain dialogue chains in the dict system that trigger chatterbox
// responses, for example random probing would yield generated responses but perhaps certain special questions would switch to a fixed responses, essentially
// triggering a cutscene or dialogue tree from a question that is presumed to be intentionally looking for a plot line. Like "what's your name" would give "i'm jimmy" ect
// but "have you ever killed anyone" to an npc with a murder quest line would switch to the quest text via chatterbox.

dialogueDictionary = ds_grid_create(19, 2); // REMEMBER TO INCREMENT

#region dialogue entries script_answerName
ds_grid_set(dialogueDictionary, 18, 0, "what do you think of");
ds_grid_set(dialogueDictionary, 18, 1, [script_answerOpinionOfOther, 1]);

ds_grid_set(dialogueDictionary, 17, 0, "do you want an item");
ds_grid_set(dialogueDictionary, 17, 1, [script_npcGiveItem, 1]); // what are the values for response choosing specifically?

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

startDialogue = function(speakerIdSet, speakerOtherSet = global.player) { // you could create two bubbles (that fill in with the typing and responses for this) and center the camera around the two speakers.. could be cool!
	live_auto_call
	
	speakerId = speakerIdSet;
	speakerId.inDialogue = true;
	speakerId.dialogueType = E_dialogueTypes.dict; // dict system
	speakerId.dialoguePartner = speakerOtherSet;
	
	// built with the assumption that only the player can use the dict system
	speakerOtherId = speakerOtherSet;
	speakerOtherSet.inDialogue = true;
	speakerOtherSet.dialogueType = E_dialogueTypes.dict; // dict system
	speakerOtherSet.dialoguePartner = speakerIdSet;
	
	x = speakerId.x;
	y = speakerId.y - 40;
}

endDialogue = function() {
	live_auto_call
	
	speakerId.inDialogue = false;
	speakerId.dialogueType = E_dialogueTypes.none; // dict system
	speakerId.dialoguePartner = noone;
	
	// built with the assumption that only the player can use the dict system
	speakerOtherId.inDialogue = false;
	speakerOtherId.dialogueType = E_dialogueTypes.none; // dict system
	speakerOtherId.dialoguePartner = noone;
	
	speakerId = noone;
	speakerOtherId = noone;
	
	dialogueString = "";
	dialogueValid = false;
}

respondToDictionaryDialogue = function(enterDialogue = false) {
	live_auto_call
	//var _entryPos = ds_grid_value_x(dialogueDictionary, 0, 0, ds_grid_width(dialogueDictionary) - 1, 0, dialogueString);
	//show_debug_message("hit " + string(_entryPos))
	//if(_entryPos != -1) {
	//	dialogueValid = 1;
	//} else {
		//dialogueValid = 0;
	//}
	
	//if(enterDialogue) { // whether the dialogue should actually be sent or just evaluated for being valid on that key (to show the green indicator that it's valid while typing)
		if(dialogueString == previousDialogueString && previousDialogueLineNpc == speakerId) { // repeating yourself and to the same person
			responseString = script_dialogueRespondToRepeatedComment(speakerId, global.player, dialogueString);
		} else {
			responseString = parseDictionaryComment(dialogueString);
		}
		//} else {
			//responseString = choose("What?", "I can't understand what you're saying.", "Hol', you're not making sense!", "Speak clearly, becher-");
		//}
		
		if(instance_exists(bubble)) { bubble.duration = 0; }
	
		var _npc = speakerId;
		bubble = script_createSpeechBubble(_npc, "white", _npc.x, _npc.y - 100, responseString, 720, 25, .5, curve_SBemerge, curve_SBgrow, ,,,,);
		
		previousDialogueString = dialogueString;
		previousDialogueLineNpc = speakerId;
		dialogueString = "";
	//}
}

parseDictionaryComment = function(commentString) {
	live_auto_call
	responseString = "No! (default)";
	
	var _words = [];
	var _commentStringLength = string_length(commentString);
	var _currentWord = "";
	var _char = "";
	
	for(var _charI = 1; _charI <= _commentStringLength; _charI++) {
		_char = string_char_at(commentString, _charI);
		if(_char == " ") {
			array_push(_words, _currentWord);
			_currentWord = "";
		} else {
			_currentWord += _char;
		}
	}
	
	if(_currentWord != "") {
		array_push(_words, _currentWord);
		_currentWord = "";
	}
	
	var _wordCount = array_length(_words);
	
	#region parsing nested if tree... this feels wrong to do this way but the result of the if chain gives the result and logic so... it's tried and true right? As long as we keep the structure simple? I dunno man
	
	try {
	
		if(_words[0] == "who") {
			if(_words[1] == "is") { // embedding checks for word count all the way down I guess...
				if(_words[2] == "the") {
					// fetch title holding and whatnot eg who is the king
				} else {
					var _nameArray = array_create(_wordCount - 2);
					array_copy(_nameArray, 0, _words, 2, _wordCount - 2); // add all remaining pieces (assumingly name fragments) to the info array
					var _npc = script_npcFindName(_nameArray);
			
					if(instance_exists(_npc)) {
						if(_npc == speakerId) {
							return $"Well! That's me! My name is {_words[2]}!";
						} else {
							return $"{_words[2]} is npc #{_npc.id}, why do you ask?";
						}
					} else {
						return "I'm not sure... Never heard of them...";
					}
				}
			} else if(_words[1] == "are") {
				if(_words[2] == "you") {
					return script_answerName(speakerId, speakerOtherId);
				}
			}
		} else if(_words[0] == "what") {
			if(_words[1] == "is") {
				if(_words[2] == "your") {
					if(_words[3] == "name") {
						return script_answerName(speakerId, speakerOtherId);
					}
				}
			} else if(_words[1] == "do") {
				if(_words[2] == "you") {
					if(_words[3] == "think") {
						if(_words[4] == "of") {
							// dictionary of keyterms that might be worth checking as well? Like check terms, if not found, check names, if not found, check ?, else assume they mispoke.. ? That seems okay, maybe conglomerate the set into a general "parseNoun" script that tries to understand what you're refering to via mass checks and dictionary checking? And you can do binary checks if sorted so I guess even a dictionary of 5000 game terms would only be like 12 checks, CS is amazing isn't it?
							var _nameArray = array_create(_wordCount - 5);
							array_copy(_nameArray, 0, _words, 5, _wordCount - 5); // add all remaining pieces (assumingly name fragments) to the info array
							var _npc = script_npcFindName(_nameArray);
							
							if(instance_exists(_npc)) {
								if(_npc == speakerId) {
									if(speakerId.selfWorth < .3) {
										return $"That's me, you realize? That's my name. Anyway, they're alright.";
									} else {
										return $"Well! That's me!";
									}
								} else {
									return $"{_words[2]} is npc #{_npc.id} and my opinion is {script_npcJudgeOtherPersonality(speakerId, _npc)}.";
								}
							} else {
								return "I'm not sure... Never heard of them...";
							}
						}
					}
				}
			} else if(_words[1] == "are") {
				if(_words[2] == "you") {
					if(_words[3] == "doing") {
						return script_answerAction(speakerId, speakerOtherId);
					}
				}
			}
		} else if(_words[0] == "when") {
	
		} else if(_words[0] == "where") {
			
		} else if(_words[0] == "why") {
	
		} else if(_words[0] == "are") {
			if(_words[1] == "you") {
				if(_words[2] == "married") {
					//answer marriage
				} else if(_words[2] == "rich") {
					return script_answerStatus(speakerId, speakerOtherId);
				} else if(_words[2] == "poor") {
					return choose("Rude.", script_answerStatus(speakerId, speakerOtherId));
				}
			}
		} else if(_words[0] == "how") {
			if(_wordCount == 1) {
				return "... \"How\" what?";
			}
			
			if(_words[1] == "are") {
				if(_words[2] == "you") {
					return script_answerMood(speakerId, speakerOtherId);
				}
			} else if(_words[1] == "old") {
				if(_words[2] == "are") {
					if(_words[3] == "you") {
						return choose("You shouldn't ask people that.", "Rude...", script_answerAge(speakerId, speakerOtherId));
					}
				}
			}
		}
	
	}
	
	catch(_error) {
		// wah do nothing (why do you need to catch an error even if you're not doing anything with it? Otherwise it crashes like normal, no try utility!
	}
	
	#region old system of direct matches... in hindsight I can see why trying to match exact phrases isn't exactly an expansive solution, though, it could probably work if you did it in depth enough with keyword swaps
	//var _responseData = ds_grid_get(dialogueDictionary, gridX, gridY); // all possible responses with criteria for each
	//var _validResponses = [];
	//var _validCount = 0;
	
	//if(is_array(_responseData[0])) {
	//	for(var _criteriaCheckI = array_length(_responseData) - 1; _criteriaCheckI > -1; _criteriaCheckI--) { // figure out which responses can't be used do to criteria and add the valid ones to valid responses []
	//		//if(_responseData[_criteriaCheckI][which pos(s) to check?] > npcFear or npcTrust or npcDrunkeness) { // success criteria based on values and checks
	//			array_push(_validResponses, _responseData[_criteriaCheckI]); //success
	//			_validCount++;
	//		//}
	//	}
	//} else {
	//	_validResponses[0] = _responseData;
	//	_validCount = 1;
	//}
	
	//msg("Valid count: " + string(_validCount));
	
	//if(_validCount > 0) {
	//	if(_validCount == 1) { // only one response which also means you don't have to do the random choosing (only one means no choosing you know?..)
	//		if(is_string(_validResponses[0][0])) {
	//			responseString = _validResponses[0][0];
	//		} else if(typeof(_validResponses[0][0]) == "ref") {
	//			responseString = _validResponses[0][0](speakerId, global.player); // need some value to store the other partner in the conversation (it won't always just be player right)
	//		}
	//	} else { // more than one working option, choose random
	//		var _randTotal = 0; //grab random from collection of possible
	//		for(var _randCountUpI = array_length(_validResponses) - 1; _randCountUpI > -1; _randCountUpI--) {
	//			_randTotal += _validResponses[_randCountUpI][1]; // the random chance component
	//		} // add up random weights
			
	//		_randTotal = random(_randTotal); // randomly pick a point within the range to be the result
			
	//		for(var _randDecayI = array_length(_validResponses) - 1; _randDecayI > -1; _randDecayI--) {
	//			_randTotal -= _validResponses[_randDecayI][1]; // the random chance component
	//			if(_randTotal <= 0) {
	//				if(is_string(_validResponses[_randDecayI][0])) {
	//					responseString = _validResponses[_randDecayI][0];
	//				} else if(typeof(_validResponses[_randDecayI][0]) == "ref") {
	//					responseString = _validResponses[_randDecayI][0](speakerId, global.player, extraValue);
	//				}
	//				break;
	//			}
	//		} // cut down the random until it "lands" on a result
	//	}
	//} // if it has no valids (which shouldn't ever happen for the record...) then it'll say the default string above.
	#endregion
	
	return "I don't understand what you're saying.";
}