///@desc This might be a bit odd right now but it should be quite elegant in the future, I hope, basically this function takes a comment "type" in english or maybe enum and runs some comparison and vibe checks on it to see how the npc should react in that moment
// basically instead of trying to bake the values for each emotion into dialogue (a solution that is more cumbersome and less flexible) I think it would be better to
// give lines of dialogue human readable vibes like "snide comment", "hopeful question", "uncertain demand", "sarcastic joke", that would then get interpreted here
// and based on the current values of the npc you're talking to get turned into emotional responses, for example a "sarcastic joke" might trigger anger or mood drop
// some of the time, if the npc was already annoyed or whatever, but it might trigger humor responses and decrease anger or fear too, I'm not sure what would guide this
// and it's complex to try and describe human emotions of course but I think a generalized system is better than trying to bake in every response and how it would impact
// the npc, me thinks a bit of random chance is better and more fun (assuming its framed with reasonable reactions) than trying to brute force a "correct" response
// so tagging lines with archetypes of comments should hopefully let them be easy to deal with instead of an array of reactions for everything that might not make sense
// We will see, I suppose...
// also put these tags in # metadata in chatter script, not in code! (DT_xxxxxxxx) for like, "dialogue_type_PLEADING"

enum E_dialogueImpactTypes {
	normal = 0,
	joke = 1,
	insult = 2,
	plead = 3,
	threat = 4,
	sarcasm = 5, // idk how these are going to work long term
}

function script_dialogueInterpretCommentType(subject, otherSpeaker, dialogueType) { // does this need a strength or power list for each emotion? Probably just magnitude for the architype here right?
	with(subject) {
		
		var _moodDif = (emotionMood - .5);
		
		if(is_string(dialogueType)) { // convert string codes to enum (int) codes, this might be necessary if coming from a format that isn't in code (like chatterscript)
			if(dialogueType == "normal") {
				dialogueType = E_dialogueImpactTypes.normal;
			} else if(dialogueType == "joke") {
				dialogueType = E_dialogueImpactTypes.joke;
			} else if(dialogueType == "insult") {
				dialogueType = E_dialogueImpactTypes.insult;
			} else if(dialogueType == "plead") {
				dialogueType = E_dialogueImpactTypes.plead;
			} else if(dialogueType == "threat") {
				dialogueType = E_dialogueImpactTypes.threat;
			} else if(dialogueType == "sarcasm") {
				dialogueType = E_dialogueImpactTypes.sarcasm;
			}
		}
		
		if(dialogueType == E_dialogueImpactTypes.normal) {
			
		} else if(dialogueType == E_dialogueImpactTypes.joke) { // really only written for joke, the others are the same as you can see. The joke impact is a very simple assumption that jokes land when the other person is in a good mood and don't when they're annoyed. It could be 100x more complex than that but for now it is what it is, also they become more angry, tired, disliking ect when the joke doesn't land / they aren't happy as well and vice versa (also doesn't take other into account at all)
			script_dialogueInfluenceNpc(id, otherSpeaker, power(_moodDif, 4), _moodDif, random(.05), -sqr(_moodDif), 0, sqr(_moodDif));
		} else if(dialogueType == E_dialogueImpactTypes.insult) {
			script_dialogueInfluenceNpc(id, otherSpeaker, power(_moodDif, 4), _moodDif, random(.05), -sqr(_moodDif), 0, sqr(_moodDif));
		} else if(dialogueType == E_dialogueImpactTypes.plead) {
			script_dialogueInfluenceNpc(id, otherSpeaker, power(_moodDif, 4), _moodDif, random(.05), -sqr(_moodDif), 0, sqr(_moodDif));
		} else if(dialogueType == E_dialogueImpactTypes.threat) {
			script_dialogueInfluenceNpc(id, otherSpeaker, power(_moodDif, 4), _moodDif, random(.05), -sqr(_moodDif), 0, sqr(_moodDif));
		} else if(dialogueType == E_dialogueImpactTypes.sarcasm) {
			script_dialogueInfluenceNpc(id, otherSpeaker, power(_moodDif, 4), _moodDif, random(.05), -sqr(_moodDif), 0, sqr(_moodDif));
		}
	}
}