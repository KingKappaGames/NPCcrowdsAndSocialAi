function script_npcGiveItem(receiver, giver, item = giver.heldItem) {	
	if(item == -1 || !instance_exists(item)) {
		return "Uh, I don't- What item?";
	} else {
		item = item.item; // _item.item is the struct within the item pick up object, this feels like a stupid way to do this...
	}
	
	var _alignmentDif = item.alignment - receiver.alignment;
	if(abs(_alignmentDif) > .7) {
		return "Wicked man, what is this foul object? Away with you!";
	} else if(_alignmentDif < -.4) {
		return "Why are you thrusting such vile things upon me?!";
	} else if(_alignmentDif > .55 && item.alignment > .7) {
		return "Ah! I can't be near that thing! It's radiance hurts my head.";
	}
	
	var _opinion = script_npcJudgeItem(receiver, item);
	
	if(_opinion < .1) {
		return $"What? No, I don't want that! What's wrong with you?";
	} else if(_opinion < .3) {
		return $"Oh. I don't really want that. Well thanks, I guess. Not really my thing though.";
	} else if(_opinion < .5) {
		return $"Ah, thanks..";
	} else if(_opinion < .7) {
		return $"Oh wow, thank you... I appreciate it.";
	} else if(_opinion < .9) {
		return $"Wow, really? Are you sure? This is great!";
	} else {
		return $"It's incredible.. Thank you, thank you!";
	}
}