///@desc Script that uses one npc to judge another, based on characteristics only, and the judgement will be one way, the two won't have the same view of each other
function script_npcJudgeOtherPersonality(subject, target) {
	var _opinion = .5;
	
	if(subject.personality == "hateful") {
		_opinion *= .85;
	} else if(subject.personality == "loving") {
		_opinion = min(_opinion * 1.1 + .05, 1);
	}
	
	_opinion -= abs(subject.alignment - target.alignment) * .42 - .12; // like less more different they are (+.15 - -.35);
	
	if(subject.religion == target.religion) {
		_opinion = min(_opinion * 1.1 + .05, 1);
	} else {
		_opinion = max(_opinion * .9 - .125, 0);
	}
	
	if(subject.homeland == target.homeland) {
		_opinion = min(_opinion * 1.1 + .05, 1);
	} else {
		_opinion = max(_opinion * .9 - .125, 0);
	}
	
	if(subject.residence == target.residence) {
		_opinion = min(_opinion * 1.05 + .03, 1);
	} else {
		_opinion = max(_opinion * .96 - .05, 0);
	}
	
	if(subject.occupation == target.occupation) {
		_opinion = min(_opinion * 1.3 + .01, 1); // if like then helps, otherwise ehhh
	}
	
	if(subject.personality == target.personality) {
		_opinion = min(_opinion * 1.25 + .05, 1);
	} else {
		_opinion = max(_opinion * .98 - .03, 0);
	}
	
	_opinion = min(_opinion * (.85 + subject.extraversion * .3), 1);
	
	_opinion = min(_opinion * (.8 + subject.joy * .4), 1);
	
	if(subject.age < 12 && target.age < 12) { // children be playing
		_opinion = min(_opinion * 1.2 + .15, 1);
	}
	
	
	return _opinion; // todo
}