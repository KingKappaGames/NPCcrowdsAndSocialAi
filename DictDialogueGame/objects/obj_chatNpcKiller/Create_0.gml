event_inherited();

chatterbox = ChatterboxCreate("chat.yarn", true);

bubbleType = "shadow";

dialogueValueCollection = {
	firstMet : 0,
	secretTold : 0,
	questDone : 0,
	itemGiven : 0,
	timesMet : 0,
	totalDialogueLinesGiven : 0 // total amount of talking to this person, can be thought of as familiarity
}

interactionRange = 50;

getDialogueResponse = function() {
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
}