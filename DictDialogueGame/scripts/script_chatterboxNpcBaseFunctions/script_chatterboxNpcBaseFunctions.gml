///@desc For now just links the speaker and npc, aka, sets their speakerId and inDialogue values
function script_chatterboxDialogueOpen(speaker) {
	speakerId = speaker;
	speakerId.inDialogue = true; 
}

///@desc For now just delinks the speaker and npc, aka, unsets their speakerId and inDialogue values
function script_chatterboxDialogueClose() {
	speakerId.inDialogue = false;
	speakerId = noone;
}

///@desc Simply loads some values from the inital comment, but perhaps can be useful for other first comment things too?
function script_chatterboxDialogueStartFirstMeeting() {
	getDialogueResponse(); // sets the chatterbox node, mostly
				
	script_chatterboxDialogueLoadTextStandard(); // sets the data from this line
				
	dialogueValueCollection.timesMet++; // other data
	dialogueValueCollection.firstMet = true; // do standard dialogue book keeping
}

///@desc Just loads the text and other data from the current node and line of dialogue that is known to be a standard comment, not a multiple choice
function script_chatterboxDialogueLoadTextStandard() {
	text = ChatterboxGetContent(chatterbox, 0);
	metadata = ChatterboxGetContentMetadata(chatterbox, 0); // get info from node
}

function script_chatterboxDialogueShutdownChat() {
	text = -1;
	speakerId.inDialogue = false;
	speakerId = noone;
	if(instance_exists(bubble)) {
		bubble.duration = 0;
	}	
}