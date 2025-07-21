event_inherited();

chatterbox = ChatterboxCreate("chatFarlands.yarn", true);

bubbleType = "white";

dialogueValueCollection = {
	firstMet : 0,
	itemGiven : 0,
	timesMet : 0,
	totalDialogueLinesGiven : 0 // total amount of talking to this person, can be thought of as familiarity
}

interactionRange = 50;

getDialogueResponse = function() {
	if(dialogueValueCollection.firstMet == 0) {
		ChatterboxJump(chatterbox, "Start");
	} else if(dialogueValueCollection.timesMet == 1) { // second time meeting
		ChatterboxJump(chatterbox, "Next");
	}
}