//script_dialogueGet...

//forms are grammar, so like, if you needed the response as a sentence insert, as in, "I'm {happy/sad/tired}!" then saying "I'm been tough!" doesn't make sense. So the forms signify whether the response is to be inserted directly, a response chunk, or a full sentence maybe?

function script_dialogueGetEmotion(subject, form){
	with(subject) { //"dreamer", "sullen", "naive", "greedy", "hateful", "loving", "lonely");
		if(form == "insert") {
			if(personality == "sullen" || personality == "hateful") {
				if(joy < .3) {
					return choose("miserable", "terrible", "awful");
				} else if(joy < .7) {
					return "fine"; // not very expressive
				} else {
					return choose("fine", "just fine"); // just fine is the best, i think, it's the most indiciative at least
				}
			} else {
				if(joy < .3) {
					return choose("not great", "pretty bad", "down");
				} else if(joy < .7) {
					return choose("alright", "doing okay", "well"); // not very expressive
				} else {
					return choose("great", "happy as can be", "lovely", "swell");
				}
			}
		} else {
			return "idk man"; // what goes here?
		}
	}
}

function script_dialogueGetWealth(subject, form, addArticle = false){ // todo on the article...
	with(subject) { //"dreamer", "sullen", "naive", "greedy", "hateful", "loving", "lonely");
		if(form == "insert") {
			if(personality == "sullen" || personality == "hateful") {
				if(wealth < 250) {
					return choose("poor", "pathetic", "dirty");
				} else if(wealth < 3000) {
					return choose("average", "irrelevant", "lower-class"); // embeded self identifier for the phrase..?
				} else if(wealth < 100_000) {
					return choose("rich", "doing well"); // embeded self identifier for the phrase..?
				} else {
					return choose("filthy rich", "undeserving");
				}
			} else if(personality == "greedy") {
				if(wealth < 250) {
					return choose("wanton " + script_dialogueGetGender(id, "insert"), "beggar");
				} else if(wealth < 3000) {
					return choose("average", "disapointing"); // embeded self identifier for the phrase..?
				} else if(wealth < 100_000) {
					return choose("elite", "worthy", "rich", "proper"); // embeded self identifier for the phrase..?
				} else {
					return choose("unrivaled", "kingly", "divine", "royal", "filthy rich");
				}
			} else {
				if(trust < .5) {
					if(wealth < 250) {
						return choose("poor", "poor");
					} else if(wealth < 3000) {
						return choose("average", "commoner"); // embeded self identifier for the phrase..?
					} else if(wealth < 100_000) {
						return choose("high-class", "rich", "wealthy"); // embeded self identifier for the phrase..?
					} else {
						return choose("divine", "royal", "filthy rich");
					}
				} else { // trusting
					if(wealth < 250) {
						return choose("poor", "beggar");
					} else if(wealth < 3000) {
						return choose("middle-class", "common " + script_dialogueGetGender(id, "insert"), "commoner"); // embeded self identifier for the phrase..?
					} else if(wealth < 100_000) {
						return choose("high-class", "dignified " + script_dialogueGetGender(id, "insert"), "elite", "rich", "wealthy"); // embeded self identifier for the phrase..?
					} else {
						return choose("unrivaled", "kingly", "divine", "royal", "filthy rich");
					}
				}
			}
		} else {
			return "idk man"; // what goes here?
		}
	}
}

function script_dialogueGetGender(subject, form) {
	if(subject.gender == 0) {
		if(subject.age < 12) {
			return "boy";
		} else if(subject.age < 70) {
			return choose("man", "boy", "chap");
		} else {
			return choose("old-man", "man", "pop", "gramps");
		}
	} else {
		if(subject.age < 12) {
			return "girl";
		} else if(subject.age < 70) {
			return choose("woman", "lady", "girl");
		} else {
			return choose("old-woman", "lady", "granny");
		}
	}
}