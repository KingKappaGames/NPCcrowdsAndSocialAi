///@desc My idea here is that these events can be used to inflict certain emotional changes on an npc without the need for a clear perpetraitor. Basically, if something happens and the npc just gets hurt for no clear reason they can run this event here for "ive been hurt, ouch." or "I'm disapointed by this, dang" and the very general cases should be useful for a foundation of response to things happening. They should be very general and make up groups of other actions as base component style events
function script_dialogueNpcEmotionalEvent(target, event, magnitude) { // the individual effect will be greater for influence than the overall, though sometimes world view may be more impacted than specific view, option for that being the mult, I leave that to you, user
	with(target) {
		var _opinionChange = 0;
		var _moodChange = 0;
		var _trustChange = 0;
		var _angerChange = 0;
		var _fearChange = 0;
		var _energyChange = 0;
		// injured or i that an action, probably an action
		if(event == 0) { // enum? (disapointted)
			
		} else if(event == 1) { // (relieved)
			
		} else if(event == 2) { // (idk man)
			
		} else if(event == 3) { // (surprised)
			
		} else if(event == 4) { // (helped)
			
		} else if(event == 5) { // (rebuked)
			
		}
		
		emotionOpinion += _opinionChange * (1 / power(abs(emotionOpinion - .5) * 2 + 1, 2.0)); // it should be harder to deviate from the center, .5, growing more and more as you get out to 1 and 1.5 ect
		emotionMood += _moodChange * (1 / power(abs(emotionMood - .5) * 2 + 1, 2.0));
		emotionTrust += _trustChange * (1 / power(abs(emotionTrust - .5) * 2 + 1, 2.0));
		emotionAnger += _angerChange * (1 / power(abs(emotionAnger - .5) * 2 + 1, 2.0));
		emotionFear += _fearChange * (1 / power(abs(emotionFear - .5) * 2 + 1, 2.0));
		emotionEnergy += _energyChange * (1 / power(abs(emotionEnergy - .5) * 2 + 1, 2.0));
	}
}