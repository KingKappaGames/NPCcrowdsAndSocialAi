function script_npcJudgeItem(subject, item){
	var _opinion = .5; // 0-1 (ish)
	
	with(subject) {
		var _valueOpinion = (max(log10(item.value), 0) / 8) - .05; // super cheap stuff is seen as junk..
		
		_valueOpinion = lerp(_valueOpinion, 0, clamp(sqr(log10(wealth) / 7), 0, 1));
		
		_opinion += _valueOpinion;
		
		_opinion += .2 - abs(alignment - item.alignment) * .5;
		
		var _itemType = item.itemType;
		if(_itemType == "junk") {
			_opinion = max(0, _opinion - .25);
		} else if(_itemType == "tool") {
			if(wealth > 5000) {
				_opinion = max(0, _opinion - .15); // rich people don't work, heh
			} else if(wealth < 1500) {
				_opinion += .1;
			}
		} else if(_itemType == "weapon") {
			if(occupation == "war worm") {
				_opinion = _opinion * 1.5 + .15;
			} else if(personality == "hateful" || combativeness > .8) {
				_opinion *= 1.25;
			} else if(personality == "loving") {
				_opinion *= .65;
			}
		}
		
		if(occupation == "scholar") {
			_opinion += item.complexity * .55; // they be loving that stuff...
		}
	}
	
	return _opinion;
}