// perhaps scripts that return a value subjectily from an npc could be called "answer+The thing they get?" Just positing a naming convention

function script_answerAge(subject) {
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

function script_answerAction(subject) {
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

function script_answerMagic(subject) {
	if(subject.magicStrength == 0) {
		if(subject.occupation == "scholar" && irandom(1) == 0) {
			return "No, I've studied it though. I don't have the talent.";
		} else if(subject.occupation == "king") {
			if(irandom(2) == 0) {
				return "A magical king? No, who's ever heard of such a thing. Now run along.";
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

function script_answerRomanticPartner(subject) {
	with(subject) {
		if(relationshipLevelPartner == "single") {
			if(irandom(1) == 0) {
				return $"I'm alone.";
			} else if(irandom(1) == 0) {
				return $"Don't be rude-";
			} else {
				return $"That... Well I'm not with anyone.";
			}
		} else {
			if(random(1) < trust) { // be cautious
				if(irandom(1) == 0) {
					return $"Yes well, I'm {relationshipLevelPartner}.";
				} else {
					return $"I'm with {relationshipPartner} and we're {relationshipLevelPartner}.";
				}
			} else {
				if(irandom(1) == 0) {
					return $"I'm not really sure why that matters..?";
				} else {
					return $"That's not something I want to tell just anyone, sorry...";
				}	
			}
		}
	}
}

function script_answerMood(subject) {
	with(subject) {
		if(trust > .3 && irandom(1) == 0) {
			return $"I'm {script_dialogueGetEmotion(id, "insert")}.";
		} else {
			return "What does it matter?";
		}
	}
}

function script_answerStatus(subject) {
	with(subject) {
		if(trust > .4 && irandom(3) != 0) {
			return $"I'm {script_dialogueGetWealth(id, "insert")}.";
		} else {
			return "Why does it matter?";
		}
	}
}