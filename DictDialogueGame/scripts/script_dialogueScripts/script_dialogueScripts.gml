// perhaps scripts that return a value subjectily from an npc could be called "answer+The thing they get?" Just positing a naming convention

function script_answerName(subject, otherSpeaker = noone) {
	with(subject) {
		if(trust > .4 && irandom(3) != 0) {
			if(irandom(1) == 0) {
				var _firstLetter = string_char_at(occupation, 1);
				var _addN = "";
				if(is_vowel(_firstLetter)) {
					_addN = "n";
				}
				
				return $"I'm {name} and I'm a{_addN} {occupation}"; // these should be wrapped in fragment getters for context and phrasing..
			} else {
				return $"My name's {name}, nice to meet you.";
			}
		} else {
			if(irandom(1) == 0) {
				return "Why does it matter?";
			} else {
				return "I'm not telling you that right now, sorry."
			}
		}
	}
}

function script_answerAge(subject, otherSpeaker = noone) {
	if(subject.age < 3) {
		return $"Goo goo ({subject.age}) ga ga bitch";
	} else if(subject.age < 11) {
		if(irandom(2) == 0) {
			return $"I'm just a kid! ({subject.age})";
		} else {
			return $"I'm {subject.age}! Hehe.";
		}
	} else if(subject.age <= 30) {
		if(irandom(1) == 0) {
			return $"{subject.age}, already.";
		} else {
			return $"{subject.age}";
		}
	} else if(subject.age < 60) {
		if(irandom(1) == 0) {
			return $"I'm {floor(subject.age / 10) * 10}...";
		} else {
			return $"{subject.age}";
		}
	} else {
		if(irandom(2) == 0) {
			return $"I'm old as dirt- {subject.age}";
		} else {
			return $"{subject.age}, not like you.";
		}
	}
}

function script_answerAction(subject, otherSpeaker = noone) {
	if(subject.pathCurrent != -1) {
		if(irandom(2) == 0) {
			return $"I'm walking. Uh.";
		} else {
			return $"I'm on my way for {path_get_name(subject.pathCurrent)}.";
		}
	} else {
		if(irandom(2) == 0) {
			return $"Standing here- Talking to you. Now what do you want?";
		} else {
			if(subject.occupation == "peasant") {
				return $"Nothing in the world.";
			} else {
				return "I need to get back to work."; // way to end dialogue from certain points?
			}
		}
	}
}

function script_answerMagic(subject, otherSpeaker = noone) {
	if(subject.magicStrength == 0) {
		if(subject.occupation == "scholar" && irandom(1) == 0) {
			return "No, I've studied it though. I don't have the talent.";
		} else if(subject.occupation == "king") {
			if(irandom(2) == 0) {
				return "A magical king? No, who's ever heard of such a thing. Now run along before I call the guard.";
			} else {
				return "Don't you know who you're talking to?";
			}
		}
		
		if(irandom(2) == 0) {
			return $"Me? No...";
		} else {
			return $"Don't suggest anything you don't mean to.";
		}
	} else {
		if(subject.occupation == "scholar" && irandom(1) == 0) {
			return "I'm well studied. That doesn't mean anything in particular...";
		} else if(subject.occupation == "king") {
			if(irandom(2) == 0) {
				return "You should know the great sorceror king Tidas! Watch your tongue.";
			} else {
				return "Don't you know who you're talking to? Magic in my blood...";
			}
		}
		
		if(irandom(2) == 0) {
			return $"Me? I uh- no.";
		} else if(irandom(1) == 0) {
			return "How would you know? Are you studied? Nevermind!";
		} else {
			return $"Don't suggest anything you don't mean to.";
		}
	}
}

function script_answerRomanticPartner(subject, otherSpeaker = noone) {
	with(subject) {
		if(relationshipLevelPartner == "single") {
			if(irandom(1) == 0) { // is this a good way to do this? Manually affecting emotions based on the chosen response ? Or is this stupid af I don't know, nor do I think I can figure this out until I see the system working more and see the shortfalls in actions
				script_dialogueInfluenceNpc(id, otherSpeaker, 0, -.01, .01, 0, .02, -.02); // add fear, add trust (hopefully this balances to create a more fragile state that if unbroken leads to trust later, or if broken now leads to a fallout where trust is lost or they get too nervous to say any more and you have to come back (time builds trust yo))
				return $"I'm alone.";
			} else if(irandom(1) == 0) {
				script_dialogueInfluenceNpc(id, otherSpeaker, -.03, -.02, -.01, 0.05, .04, .03); // add fear, add trust (hopefully this balances to create a more fragile state that if unbroken leads to trust later, or if broken now leads to a fallout where trust is lost or they get too nervous to say any more and you have to come back (time builds trust yo))
				return $"Don't be rude-";
			} else {
				script_dialogueInfluenceNpc(id, otherSpeaker, 0, -.05, .01, 0, .02, .01); // add fear, add trust (hopefully this balances to create a more fragile state that if unbroken leads to trust later, or if broken now leads to a fallout where trust is lost or they get too nervous to say any more and you have to come back (time builds trust yo))
				return $"That... Well, I'm not with anyone.";
			}
		} else {
			if(random(1) < trust) { // be cautious
				if(irandom(1) == 0) {
					script_dialogueInfluenceNpc(id, otherSpeaker, 0, 0, .03, 0, .03, .02); // add fear, add trust (hopefully this balances to create a more fragile state that if unbroken leads to trust later, or if broken now leads to a fallout where trust is lost or they get too nervous to say any more and you have to come back (time builds trust yo))
					return $"Yes, well, I'm {relationshipLevelPartner}.";
				} else {
					script_dialogueInfluenceNpc(id, otherSpeaker, 0, 0, .03, 0, .03, .02); // add fear, add trust (hopefully this balances to create a more fragile state that if unbroken leads to trust later, or if broken now leads to a fallout where trust is lost or they get too nervous to say any more and you have to come back (time builds trust yo))
					return $"I'm with {relationshipPartner.name} and we're {relationshipLevelPartner}.";
				}
			} else {
				if(irandom(1) == 0) {
					script_dialogueInfluenceNpc(id, otherSpeaker, -.02, -.02, -.02, 0, .02, 0);
					return $"I'm not really sure why that matters..?";
				} else {
					script_dialogueInfluenceNpc(id, otherSpeaker, 0, -.01, -.01, 0.04, .03, 0.02);
					return $"That's not something I want to tell just anyone, sorry...";
				}	
			}
		}
	}
}

function script_answerMood(subject, otherSpeaker = noone) {
	with(subject) {
		if(trust > .3 && irandom(1) == 0) {
			return $"I'm {script_dialogueGetEmotion(id, otherSpeaker, "insert")}.";
		} else {
			return "What does it matter?";
		}
	}
}

function script_answerStatus(subject, otherSpeaker = noone) {
	with(subject) {
		if(trust > .4 && irandom(3) != 0) {
			return $"I'm {script_dialogueGetWealth(id, otherSpeaker, "insert")}.";
		} else {
			return "Why does it matter?";
		}
	}
}

function script_answerOpinionOfOther(subject, otherSpeaker = noone, target = noone) {
	if(instance_exists(target)) {
		var _opinion = script_npcJudgeOtherPersonality(subject, target);
		
		if(_opinion < .2) {
			return "They're- I don't want to talk about them... Egh.";
		} else if(_opinion < .5) {
			return "Not, well.. I'm not fond.";
		} else if(_opinion < .8) {
			return "I like em!";
		} else {
			return "Are you kidding? They're a hero of mine. Don't tell them I said that, or, uh, nevermind.";
		}
	} else {
		if(target == noone) {
			return "I don't think about the void as a person but go ahead.";
		} else {
			return "I'm not sure who that is...";
		}
	}
}