function script_dialogueRespondToRepeatedComment(subject, otherSpeaker, comment) {
	var _option = irandom(5);
	
	if(_option == 0) {
		return "Why are you repeating yourself?";
	} else if(_option == 1) {
		return "You just said that..";
	} else if(_option == 2) {
		return "I just told... I don't really know... what you're getting at.";
	} else if(_option == 3) {
		return "I'm not going to repeat myself.";
	} else if(_option == 4) {
		return "Is this some kind of joke?";
	} else if(_option == 5) {
		return "Did you not hear me last time?";
	}
}