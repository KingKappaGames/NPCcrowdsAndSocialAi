if(live_call()) { return live_result }

if(instance_exists(speakerId)) {
	if(keyboard_check_released(vk_enter)) {
		respondToDictionaryDialogue(1);
	}
	
	var _textChanged = false;
	
	if(keyboard_check_pressed(vk_backspace)) {
		dialogueString = string_delete(dialogueString, string_length(dialogueString), 1);
		_textChanged = true;
	} else if(keyboard_check_pressed(keyboard_lastkey)) {
		var _uni = real(keyboard_lastkey);
		//gameMsg(_uni); // if you are a lost soul looking for the ascii or whatever code this is (uni? But what?) then activate this and find out with the debug console. EZ PZ 
		if((_uni > 47 && _uni < 58) || (_uni > 64 && _uni < 91) || _uni == 32 || _uni == 189 || _uni == 190) {
			if(_uni == 189) {
				if(keyboard_check(vk_shift)) {
					dialogueString = string_insert("_", dialogueString, string_length(dialogueString) + 1);
					_textChanged = true;
				} else {
					dialogueString = string_insert("-", dialogueString, string_length(dialogueString) + 1);
					_textChanged = true;
				}
			} else if(_uni == 190) {
				dialogueString = string_insert(".", dialogueString, string_length(dialogueString) + 1);
				_textChanged = true;
			} else {
				if(keyboard_check(vk_shift)) {
					dialogueString = string_insert(chr(keyboard_lastkey), dialogueString, string_length(dialogueString) + 1);
					_textChanged = true;
				} else {
					dialogueString = string_insert(string_lower(chr(keyboard_lastkey)), dialogueString, string_length(dialogueString) + 1);
					_textChanged = true;
				}
			}
		}
	}
	
	if(keyboard_check_released(vk_up)) {
		dialogueString = previousDialogueString;
		_textChanged = true;
	}
	
	if(_textChanged) {
		//parseDialogue(); // hmmm
	}
} else {
	speakerId = noone;
}