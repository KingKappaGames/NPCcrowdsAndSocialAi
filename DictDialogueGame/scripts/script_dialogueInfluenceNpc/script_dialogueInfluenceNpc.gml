function script_dialogueInfluenceNpc(target, otherSpeaker, opinionChange, moodChange, trustChange, angerChange, fearChange, energyChange) {
	with(target) {
		emotionOpinion += opinionChange;
		emotionMood += moodChange;
		emotionTrust = trustChange;
		emotionAnger = trustChange;
		emotionFear = fearChange;
		emotionEnergy = energyChange;
		
		// adding emotions into others in sets is the "emotional alchemy" system, for now a simpel addition but probably should be much more complex...
	}
}