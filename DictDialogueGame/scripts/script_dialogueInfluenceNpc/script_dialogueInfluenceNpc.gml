function script_dialogueInfluenceNpc(target, otherSpeaker, opinionChange, moodChange, trustChange, angerChange, fearChange, energyChange) {
	with(target) {
		emotionOpinion += opinionChange * (1 / power(abs(emotionOpinion - .5) * 2 + 1, 2.0)); // it should be harder to deviate from the center, .5, growing more and more as you get out to 1 and 1.5 ect
		emotionMood += moodChange * (1 / power(abs(emotionMood - .5) * 2 + 1, 2.0));
		emotionTrust += trustChange * (1 / power(abs(emotionTrust - .5) * 2 + 1, 2.0));
		emotionAnger += trustChange * (1 / power(abs(emotionAnger - .5) * 2 + 1, 2.0));
		emotionFear += fearChange * (1 / power(abs(emotionFear - .5) * 2 + 1, 2.0));
		emotionEnergy += energyChange * (1 / power(abs(emotionEnergy - .5) * 2 + 1, 2.0));
		
		// adding emotions into others in sets is the "emotional alchemy" system, for now a simple addition but probably should be much more complex...
	}
}