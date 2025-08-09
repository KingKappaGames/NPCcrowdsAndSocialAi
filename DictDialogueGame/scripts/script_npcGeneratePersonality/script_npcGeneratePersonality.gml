function script_npcGeneratePersonality(){
	//first things to be established (perhaps before manually set things? So that you can pass in the needed things and it'll fill out around those down the chart?)
	
	//each value should probably have a return type for the values it gives, for example, the region of "pride lands" should have a function that returns a range of ages expected for the pride lands. These values would then get multiplied by other factors to yield a more realistic age value from the context. This system also keeps values contained, one region yields one age range, gender, occupation, ect would all have their own ranges that get factored in but they don't mix initially.
	
	if(residence == -1) {
		residence = choose("pride lands", "dark realm", "quiet vegas", "surface", "reaches"); // specific city or village, not house, not region (could be none / travellor maybe?)
	}
	if(homeland == -1) {
		homeland = choose(residence, residence, residence, residence, "pride lands", "dark realm", "quiet vegas", "surface", "reaches"); // dist based association, aka the closer the homeland, the more likely the residence
	}
	if(gender == -1) { // male, female (0,1)
		gender = irandom(1); // affected by society (male / female dominated groups will have harsher gender divides, perhaps this is one of the passed values?)
	}
	if(age == -1) {
		age = random(200);
		if(homeland == "surface" || residence == "surface") {
			age = random(100); // random thing, ages aren't as high when you're mortal or mortal adjacent, this obviously would need expanded but still
		}
	}
	if(objectAllegiance == -1) {
		objectAllegiance = irandom(allegianceCount - 1);
		if(residence == "pride lands") {
			if(homeland == "pride lands") {
				if(random(1) > .2) {
					objectAllegiance = ALLEGIANCES.proudApostle;
				} else if(random(1) < .1) {
					objectAllegiance = ALLEGIANCES.neutral;
				}
			} else {
				if(random(1) > .6) {
					objectAllegiance = ALLEGIANCES.proudApostle;
				} else if(irandom(2) == 0) {
					if(homeland == "dark lands") {
						objectAllegiance = ALLEGIANCES.fatalists;
					} else if(homeland == "quiet vegas") {
						objectAllegiance = ALLEGIANCES.neutral;
					}
					//get allegiances from region of home land
				}
			}
		}
	}
	
	
	if(occupation == -1) {
		if(age < 11) {
			occupation = "child"; 
		} else { // ??? children can't work i guess
			if(residence == "quiet vegas") {
				occupation = choose("gambler", "feaster", "wanderer", "neuveu lord", "packer");
			} else if(residence == "dark realm") {
				occupation = choose("witness", "rotted", "guide", "knight", "packer", "cultist");
			} else if(residence == "surface") {
				occupation = choose("bard", "knight", "wizard", "noble", "peasant", "king", "craftsman", "slave");
			} else if(residence == "pride lands") {
				occupation = choose("lord", "wanderer", "cultivator", "scholar", "worshipper", "packer");
			}
			
			if(gender == 1) {
				if(irandom(10) == 0) {
					occupation = "sustress";
				}
			} else {
				if(irandom(20) == 0) {
					occupation = "war worm";
				}
			}
		}
	}
	if(religion == -1) {
		religion = choose("proud soul", "reach follower", "mortalist", "fatalist");
	}
	if(wealth == -1) {
		wealth = power(irandom(20), 5);
		
		if(occupation == "lord") {
			wealth = wealth * irandom_range(10, 300) + 25300; // make lords some degree of rich
		} else if(occupation == "neuveu lord" || occupation == "scholar" || occupation == "king") {
			wealth = wealth * 3 + irandom_range(5000, 30000);
		} else if(occupation == "witness" || occupation == "feaster" || occupation == "worshipper") {
			wealth = clamp(irandom(1000) - irandom(1000), 0, 900000); // these fields should have very little if not no money
		}
	}
	if(status == -1) {
		if(occupation == "lord") {
			status = "lord";
		} else if(occupation == "witness") {
			status = "witness";
		} else {
			status = round(sqrt(sqrt(wealth)));
			if(status < 250) {
				status = "empty";
			} else if(status < 5000) {
				status = "tethered";
			} else if(status < 100000) {
				status = "ruler";
			} else if(status < 2000000) {
				status = "algam";
			} else {
				status = "false lord";
			}
		}
	}
	
	if(alignment == -1) {
		if(occupation == "lord") {
			alignment = choose(0, 1);
		} else {
			alignment = 1 - (wealth / (wealth + 1000));
		}
	}
	
	if(criminality == -1) {
		criminality = random(1);
		if(occupation == "packer") {
			criminality = 0;
		}
	}
	if(magicStrength == -1) {
		if(occupation == "lord" || occupation == "witness") {
			magicStrength = 1;
		} else if(residence == "surface") {
			magicStrength = clamp(random(1) - random(1) + random(occupation == "scholar"), 0, 1); // butchery honestly
		} else {
			magicStrength = random(1);
		}
	}
	if(magicField == -1) {
		magicField = irandom(5); // idk some fields of magic that randomly choose from
	}
	if(powerLevel == -1) {
		powerLevel = clamp(sqr(magicStrength) + sqr(wealth / (wealth + 100000)), 0, 1);
	}
	
	if(extraversion == -1) {
		extraversion = random(1);
		if(occupation == "witness" || occupation == "feaster" || occupation == "neuveu lord" || occupation == "rotted") {
			extraversion *= .5;
		}
	}
	if(selfWorth == -1) {
		if(occupation == "witness" || occupation == "feaster" || occupation == "neuveu lord" || occupation == "rotted" || occupation == "lord") {
			selfWorth = 1;
		} else {
			if(irandom(1) == 0) {
				selfWorth = clamp(random(1) * powerLevel + random(1), 0, 1);
			} else {
				selfWorth = random(1 - (alignment - criminality/*actualMoral*/)); // moral dissonance is what ruins your self esteem
			}
		}
	}
	if(personality == -1) {
		personality = choose("dreamer", "sullen", "naive", "greedy", "hateful", "loving", "lonely");
	}
	if(relationshipLevelPartner == -1) {
		relationshipLevelPartner = choose("single", "friend", "dating", "engaged", "married");
		if(relationshipLevelPartner != "single") {
			relationshipPartner = instance_find(obj_npc, irandom(instance_number(obj_npc) - 1));	
			if(relationshipPartner == id) { // can't be married to yourself yo
				relationshipPartner = noone;
				relationshipLevelPartner = "single";
			} else {
				if(personality == "hateful") {
					relationshipPartner = noone;
					relationshipLevelPartner = "single"; // idk basic quality setting vs relationship (hateful means no marriage I guess?)
				}
			}
		} else {
			relationshipPartner = noone;
		}
	}
	if(trust == -1) {
		trust = random(1);
	}
	if(energyPersonality == -1) {
		energyPersonality = random(1); // this would be vitality/how spry they were, age is a big impact but also magic and history
	}
	if(joy == -1) {
		joy = random(1);
	}
	if(curiosity == -1) {
		curiosity = random(1);
	}
	if(combativeness == -1) {
		combativeness = random(1);
	}
	if(knowledgeGeneral == -1) {
		knowledgeGeneral = random(1);
	}
	if(speedValue == -1) {
		speedValue = .25 + random(1);
	}
	if(weightValue == -1) {
		weightValue = .25 + random(1);
	}
	if(keenness == -1) {
		keenness = random(1);
	}
	
	//if( == -1) {
		
	//}

	//social relations (array of people or trades (or races?? genders??) and how they feel about them)
	//goals/desires V see below
	//dislikes/likes, categories or items (fears, disgusts, curiosities, ect)
	//home (building)
	//more personality values, more specific (knowledge)
	//secrets
	//hobbies (could these be goals? Like a routine goal to take a walk at a certain time such that the desire to do so has to compete like all other behavior goals for that time?)
	//physical characteristics like height
	//equipment




	//last things that fill in

	//extra effects like disabilities, past experiences, stats, equipment, ... and suddenly the scope just bloomed 10x But you know what I'm saying, extra little things like a limp for ex could be sprinkled into the npcs at the end based on their circumstance, maybe retired knights or guards would have a high likelyhood of having injuries or such, that kind of thing

	//maybe there could be goals/desires built into npcs such that they do a given action if the requirements are met? This could be simple things like going home once work is done or a time is met but also leaving the city and moving away if they reach a certain money amount... THis could REALLy dynamicize the world but also sounds very complex... Hm... But to be fair you could simply store it as [action, criteria, desireOfThisGoal]
	//these goal states could balance with each and include basic actions such as returning lost items to the guards. For example the desire to return an item (on finding an item) would be: sqrt(value), however they would have a desire to keep the item, say, or leave it, perhaps "stealing" would be it's own logic that would consider the npcs around them and return a desire value to steal, high if noone around, very low if surrounded by guards
	//I feel that these interacting and intercalculating pushes and pulls would yield insanely complex emergent behavior but not require that much depth of design, simply balance all the wants and dis-wants and it'll handle itself automatically... In theory... You, the greater reason, will know if this is the best idea I ever had and it revolutionized the genre or if I realize it's stupid for some reason and give up on it, that's if ai doesn't do it already.. ): But also (: eh.

	//similar to goals perhaps certain behaviors would be associated with values of trust or fearfulness so that maybe an npc wants to use magic to do something but they have to use their "magic related behaviors" and those behaviors have a high fear cost, thus the npc would have to overcome that fear or go around it (if no ones around?) to do the behaviors behind desire/fear barriers. Again, sounds complex but I feel that there is a way to mix all this together and get a really nice, smooth, in and out goal system that can handle dynamic inputs.
	//perhaps when npcs do things they are tagged with certain values or associations so that other npcs can judge them as tags but also perhaps the action itself gets a multiplier or something so that when judged the judgers have to balance the thing itself with the circumstance of it happening. For example using magic to save someone life would carry a negative to magic and a positive to saving life, but even deeper if that life is not valued then the benefit is null. 
	//Perhaps all influences and tags like, magic, saving, fighting, talking, sneaking, ect are tagged with influence values such as "suspicious, evil, good, scary, kind" but also associated relations so kindness to evil would be seen as evil and suspicion to evil would be seen as heroic... Again, again, this is complex and scope bloom but I just want to note all the options and see which ones are doable and how I might go about them
	//then each npc might have a current state that would contain their influences, so if they do something bad for a good reason they would have bad aspects and trust negatives and fear and all that but those values would be molded by the context leaving them in a good state, fear and trust but also commendable, their actions would carry connotations but their overall state would reflect their actions in the recent moments and npc judgements would be based on that. Npcs interacting with others might also have their current karmic state influenced by their actions on other npcs with a given karmic state so that dynamic states reflect on other npc's dynamic states.

	//perhaps this is unnecessary given that I've talked a ton about this already but this system would make npcs mad if a random attacked someone they percieve as good and happy if someone attacked the attacker since they had bad karmic context. The npc that killed the attacker would then be liked or at least not suffer any negative associated with killing a kin. This is one layer deep in a way but the layer morphs from action to action... Hype but also, good luck actually making it happen.
	
	image_blend = c_white;
	
	//maybe at the end all the values should be remerged to create a slightly higher homogenaity in the values you end up with? Or not, i dunno
}