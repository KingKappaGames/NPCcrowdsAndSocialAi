chatterbox = noone;

speakerId = noone; // the OTHER person in this dialogue, not me!

text = -1;
metadata = -1;

bubble = noone;
bubbleType = choose("shadow", "white");

dialogueValueCollection = noone;

interactionRange = 50;


optionChosenArrayDebug = -1;
optionCriteriaArrayDebug = -1;

/// @desc Function Jumps to the next node based on the conditions and tree of this npcs dialogue, then the frame of the dialogue grabs that info and creates comments with it
getDialogueResponse = function() {
	//overwritten by the specific npc
}