event_inherited();

chatterbox = ChatterboxCreate("chatFarlands.yarn", true);

bubbleType = "white";

dialogueValueCollection = {
	itemGiven : 0,
	timesMet : 0,
	totalDialogueLinesGiven : 0 // total amount of talking to this person, can be thought of as familiarity
}

interactionRange = 50;

getDialogueResponse = function() {
	if(dialogueValueCollection.timesMet == 0) {
		ChatterboxJump(chatterbox, "Start");
	} else if(dialogueValueCollection.timesMet == 1) { // second time meeting
		ChatterboxJump(chatterbox, "Next");
	}
}

name = "Owul the Disloyal";
age = 239;
magicStrength = .94;