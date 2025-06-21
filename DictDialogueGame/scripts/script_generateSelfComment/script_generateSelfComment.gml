function script_generateSelfComment() {
	//calculate context of the npc into a rough break down of importance and draw a subject from the potential considerations... ?
	var _weather = global.weather; 
	var _time = global.time;
	var _place = global.territory;
	
	if(_time == "morning" && irandom(4) == 0) {
		return ["I hate mondays.", "As you should.", "Egh.", "You can't silence me.", "Mondays? You know, anti las?", ["Keep laughing, I'm coming for your calendar.", "You get it.", "Lock your door tonight.", "You don't scare me.", "Are you stupid, I'm going to ruin your week.", "You're lucky clown."]];
	} else if(_place == "pride lands" && irandom(4) == 0) {
		return ["[wave]The lord lies deep, the lands grow rich and toiled...[/wave]", "My hands are worn, the valley's man, I am a proud lands soul. Good day visitor.", "Hm. It's only a saying.", "Is there a problem?", "Hm? It's an old verse, you've never heard?", "Aye, common man we are"];
	} else {
		return ["Hm hm hm...", "Oh, hi.", "Huh?", ["Huh? What do you want?", "Alright.", "Sure, good day to you.", "I don't like bullies.", "I thought you were saying something. Glad I was wrong.", "We don't want you here."], "I'm just minding my buisness, don't want any trouble.", "Aha..."];
	}
}