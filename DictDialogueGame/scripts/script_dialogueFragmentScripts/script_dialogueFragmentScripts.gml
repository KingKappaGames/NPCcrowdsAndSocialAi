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