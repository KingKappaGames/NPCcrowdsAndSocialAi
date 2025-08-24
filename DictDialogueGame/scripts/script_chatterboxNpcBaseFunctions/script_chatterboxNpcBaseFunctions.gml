///@desc For now just links the speaker and npc, aka, sets their dialoguePartner, dialogueType, and inDialogue values
function script_chatterboxDialogueOpen(speaker) {
	inDialogue = true;
	dialogueType = E_dialogueTypes.chatterbox;
	dialoguePartner = speaker;
	
	dialoguePartner.inDialogue = true;
	dialoguePartner.dialogueType = E_dialogueTypes.chatterbox;
	dialoguePartner.dialoguePartner = id; // this is cursed, each value basically is reflexive
}

///@desc For now just delinks the speaker and npc, aka, unsets their dialoguePartner, dialogueType and inDialogue values
function script_chatterboxDialogueClose() {	
	if(instance_exists(dialoguePartner)) {
		dialoguePartner.inDialogue = false;
		dialoguePartner.dialogueType = E_dialogueTypes.none;
		dialoguePartner.dialoguePartner = noone; // this is cursed, each value basically is reflexive
	}
	
	inDialogue = false;
	dialogueType = E_dialogueTypes.none;
	dialoguePartner = noone;
	
	text = -1;
}

///@desc Simply loads some values from the inital comment OF A GIVEN CONVERSATION, does not do the very first conversation ever had with an npc!
function script_chatterboxDialogueStartMeeting() {
	getDialogueResponse(); // sets the chatterbox node, mostly
	
	script_chatterboxDialogueLoadTextStandard(); // sets the data from this line
	
	dialogueValueCollection.timesMet++; // each first comment in a dialogue is a time met, I suppose a dialogue thread isn't really a whole "meeting", you could define them as times greeted or subjects passed, if you need subjects to flow in order, since actual times going to see them doesn't really matter for anything but vibes which can be dealt with in other ways
	// uh, what else?
}

///@desc Just loads the text and other data from the current node and line of dialogue that is known to be a standard comment, not a multiple choice
function script_chatterboxDialogueLoadTextStandard() {
	text = ChatterboxGetContent(chatterbox, 0);
	metadata = ChatterboxGetContentMetadata(chatterbox, 0); // get info from node
}

function script_chatterboxDialogueShutdownChat() {
	text = -1;
	
	script_chatterboxDialogueClose(); // cuts the two speakers out
	
	if(instance_exists(bubble)) {
		bubble.duration = 0;
	}	
}