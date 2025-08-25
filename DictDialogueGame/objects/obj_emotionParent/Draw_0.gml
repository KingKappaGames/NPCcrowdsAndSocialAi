if(keyboard_check_pressed(vk_control)) {
	showDebug = (showDebug + 1) % (instance_number(obj_npc) + 1);
}
	
if(showDebug > 0) {
	draw_text(x - 60, y, showDebug);
	
	var _emotions = [emotionOpinion, emotionMood, emotionTrust, emotionAnger, emotionFear, emotionEnergy];
	var _color = [c_white, c_yellow, c_green, c_red, c_purple, c_orange];
	for(var _i = 0; _i < 6; _i++) {
		draw_set_color(_color[_i]);
		draw_circle(x + dcos(_i * 60) * 27, y - dsin(_i * 60) * 27, max(3 + sqr(1 + abs(_emotions[_i]) * 2) - 1, 0), (_emotions[_i] < 0));
	}
	draw_set_color(c_white);
	
	if(showDebug > 1) {
		var _data = [
		id,
		name,
		residence,
		homeland,
		gender,
		age,
		objectAllegiance,
	
		occupation,
		religion,
		wealth,
		status,
		alignment,                              /// monka bro wtf
		criminality,
		magicStrength,
		magicField,
		powerLevel,
	
		extraversion,
		selfWorth,
		personality,
		trust,
		energyPersonality,
		joy,
		curiosity,
		combativeness,
		knowledgeGeneral, 
	
		speedValue,
		weightValue,
		keenness,
	
		emotionOpinion,
		emotionMood,
		emotionTrust,
		emotionAnger,
		emotionFear,
		emotionEnergy,
		];
	
		var _dataNames = [
		"id",
		"name",
		"residence",
		"homeland",
		"gender",
		"age",
		"objectAllegiance",
	
		"occupation",
		"religion", /// monka bro wtf
		"wealth",
		"status",
		"alignment",
		"criminality",
		"magicStrength",
		"magicField",
		"powerLevel",
	
		"extraversion",
		"selfWorth",
		"personality",
		"trust",
		"energyPersonality",
		"joy",
		"curiosity",
		"combativeness",
		"knowledgeGeneral",
	
		"speedValue",
		"weightValue",
		"keenness",
	
		"emotionOpinion",
		"emotionMood",
		"emotionTrust",
		"emotionAnger",
		"emotionFear",
		"emotionEnergy",
		];
	
		for(var _i = array_length(_data) - 1; _i >= 0; _i--) {
			draw_set_halign(fa_right);
			draw_text_transformed(x + 60, y - 200 + _i * 12, _data[_i], .8, .8, 0);
			draw_set_halign(fa_left);
			draw_text_transformed(x + 70, y - 200 + _i * 12, _dataNames[_i], .8, .8, 0);
		}
	}
	
	if(showDebug > 2) { // show opinion between npcs
		if(current_time % 1000 > 986) { // cut milliseconds for one frame, this is a stupid way to do this but long used for its simplicity.. screw you bro for not having a built in frame counter
			var _npc = instance_find(obj_npc, showDebug - 2);
			
			if(instance_exists(_npc)) {
				var _opinion = script_npcGetOpinionData(_npc);
				if(_opinion != noone) {
					var _data = [
					_opinion.opinion,
					_opinion.mood,
					_opinion.trust,
					_opinion.anger,
					_opinion.fear,
					_opinion.energy,
					_opinion.debt,
					];
	
					var _dataNames = [
					"opinion",
					"mood",
					"trust",
					"anger",
					"fear",
					"energy",
					"debt"
					];
	
					
					script_createDataArrow(x, y, _npc, _data, _dataNames, 60);
				}
			}
		}
	}
}