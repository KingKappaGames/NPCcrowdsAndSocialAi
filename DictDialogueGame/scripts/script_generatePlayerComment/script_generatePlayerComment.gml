function script_generatePlayerComment(){
	//calculate context of the npc into a rough break down of importance and draw a subject from the potential considerations... ?
	var _weather = global.weather; 
	var _time = global.time;
	var _place = global.territory;
	
	if(_place == "pride lands" && irandom(1) == 0) {
		return ["A visitor to the [#fca3ff]pride lands[c_white]?", "Well, it's nice enough. Make yourself at home.", "A countryman. Well met.", "Woah. Calm down, it's only a pleasantry.", "Didn't you know? These are the kings realms.", "Uh, what did I say?"];
	} else if(_time == "day" || _time == "morning" || _time == "noon") {
		return ["Good day.", "Mm.", "...", "Is there a problem?", "I said good day, that's all.", "Right..."];
	} else {
		return ["Hello.", "Good to see ya.", "Suit your self.", "I didn't mean anything by it.", "Huh?", "It's a fine day isn't it?"];
	}
}