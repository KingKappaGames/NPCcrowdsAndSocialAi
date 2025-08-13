function script_itemGenerateValues(item, itemDropId = noone){
	with(item) {
		if(itemType == -1) {
			itemType = choose("tool", "weapon", "resource", "junk", "food");
		}
		if(alignment == -1) {
			alignment = random(1);
		}
		if(value == -1) {
			value = sqr(irandom(100));
		}
		if(complexity == -1) {
			complexity = random(1);
		}
		if(magical == -1) {
			magical = random(1);
		}
		if(danger == -1) {
			danger = random(1);
		}
		if(weight == -1) {
			weight = round(sqr(random(5)) * .1) * 10; // squarely heavy and rounded to .1 pounds
		}
		
		
		if(itemType == "junk") {
			value *= .04;
			danger *= .25;
			magical *= .7;
			alignment = lerp(alignment, .5, .5); // junk can't be that crazy right?
		} else if(itemType == "food") {
			value *= .4; // how much can one banana cost?
			danger *= .4;
			magical *= .65;
			weight *= .5;
			alignment = lerp(alignment, .6, .5); // food is chill, and generally goodish?
		} else if(itemType == "weapon") {
			danger = danger * 2 + .5;
			magical *= 1.2;
		}
		
		if(owner == -1) {
			if(irandom(2) != 0) { // assign owner or don't..
				owner = instance_find(obj_npc, irandom(instance_number(obj_npc) - 1));
			} else {
				owner = noone;
			}
		}
	}
}