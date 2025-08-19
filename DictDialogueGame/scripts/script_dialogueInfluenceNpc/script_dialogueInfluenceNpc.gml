function script_dialogueInfluenceNpc(target, otherSpeaker, opinionChange, moodChange, trustChange, angerChange, fearChange, energyChange) {
	with(target) {
		emotionOpinion += opinionChange * (1 / power(abs(emotionOpinion - .5) * 2 + 1, 2.0)); // it should be harder to deviate from the center, .5, growing more and more as you get out to 1 and 1.5 ect
		emotionMood += moodChange * (1 / power(abs(emotionMood - .5) * 2 + 1, 2.0));
		emotionTrust += trustChange * (1 / power(abs(emotionTrust - .5) * 2 + 1, 2.0));
		emotionAnger += trustChange * (1 / power(abs(emotionAnger - .5) * 2 + 1, 2.0));
		emotionFear += fearChange * (1 / power(abs(emotionFear - .5) * 2 + 1, 2.0));
		emotionEnergy += energyChange * (1 / power(abs(emotionEnergy - .5) * 2 + 1, 2.0));
		
		if(object_index == obj_npc) { // only "npc" object has movement and follower logic yo!
			if(followingId == noone && emotionOpinion > 1 && opinionChange > .25) { // very well liked and a big increase in this moment, meant to be one of those "this person is great and look at what they can do at their best, I'm proud to follow this person" anime type nonsense
				followingPoint = true; // flash point social view
				followingId = global.player;
			
				comment = "Friend, I'll be with you wherever you go."; // player focused comment
				script_createSpeechBubble(id, "shadow", x + choose(-40, 40), y - 100, comment, 120, 80, .5, curve_SBemerge, curve_SBgrow);
			} else if(followingId == global.player && emotionOpinion < .25 && opinionChange > .2) {
				followingId = noone;
				followingPoint = false;
			
				comment = "I can't believe I ever followed you, you're no better than any of these... horrible people!"; // player focused comment
				script_createSpeechBubble(id, "shadow", x + choose(-40, 40), y - 100, comment, 190, 80, .7, curve_SBemerge, curve_SBgrow);
			}
		}
		// adding emotions into others in sets is the "emotional alchemy" system, for now a simple addition but probably should be much more complex...
	}
}