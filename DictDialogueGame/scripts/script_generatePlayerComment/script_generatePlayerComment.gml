function script_generatePlayerComment(){
	//calculate context of the npc into a rough break down of importance and draw a subject from the potential considerations... ?
	var _weather = global.weather; 
	var _time = global.time;
	var _place = global.territory;
	
	if(emotionOpinion < .15) {
		return ["What do *you* want?"];
	} else if(emotionMood < .15) {
		return ["Leave me alone."];
	} else if(emotionTrust < .15) {
		return ["You? I don't want anything to do with you."];
	} else if(emotionEnergy < .15) {
		return ["Hm..? Oh.. hey..."]; // break edge low stats > high stats
	} else if(emotionOpinion > .85) {
		return ["Well met! Anything I can do for ya, pal?"];
	} else if(emotionMood > .85) {
		return ["Oh! It's good to see you... Times are great aren't they?"];
	} else if(emotionTrust > .85) {
		return ["Heyyy. Yo."];
	} else if(emotionAnger > .85) {
		return ["Leave me be!"];
	} else if(emotionFear > .85) {
		return ["Get away from me!"];
	} else if(emotionEnergy > .85) {
		return ["Oh it's you! Hey! How are you!?"];
	}
	
	if(_place == "pride lands" && irandom(1) == 0) {
		return ["A visitor to the [#fca3ff]pride lands[c_white]?", "Well, it's nice enough. Make yourself at home.", "A countryman. Well met.", "Woah. Calm down, it's only a pleasantry.", "Didn't you know? These are the kings realms.", "Uh, what did I say?"];
	} else if(_time == "day" || _time == "morning" || _time == "noon") {
		return ["Good day.", "Mm.", "...", "Is there a problem?", "I said good day, that's all.", "Right..."];
	} else {
		return ["Hello.", "Good to see ya.", "Suit your self.", "I didn't mean anything by it.", "Huh?", "It's a fine day isn't it?"];
	}
}