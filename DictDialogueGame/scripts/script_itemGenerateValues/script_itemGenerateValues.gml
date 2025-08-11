function script_itemGenerateValues(item, itemDropId = noone){
	with(item) {
		if(itemType == -1) {
			itemType = choose("tool", "weapon", "resource", "junk");
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
		
		if(itemType == "junk") {
			value *= .04;
			alignment = lerp(alignment, .5, .5); // junk can't be that crazy right?
		}
	}
}