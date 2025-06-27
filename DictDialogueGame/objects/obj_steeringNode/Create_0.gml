if(live_call()) { return live_result }

influenceStrength = random_range(-1, 1);
influenceDirectContact = influenceStrength * 2;

influenceRadius = 200;
influenceConsequenceRadius = 40;

influenceDirection = 0;
influenceDirectionRange = 0;
directionMatchType = 0; // 0 is no preference, 1 is if in range full effect, 2 is more preference for more aligned

influenceRangeMax = 1;
influenceRangeOfValue = 1; // how far from the max you go as you go farther off point (1 max plus 1 range would mean 1-0, 2 max 5 range would mean 2-(-3) and flipping plus dir plus influence strength gives you all other controls

influenceShape = 0; // uhhhh, 0 is move away? I guess these should be indexes for shape masks..?
//have a way to specify the impact of the influence, like some will pull more the closer you are, some will pull to a certain range then stop, some will effect you more the further you are

enum influenceShapes {
	fanOneToZero,
	fanOneToNegOne,
	fanWeightedOneTo // ???
}

getInfluence = function(npc, dist = undefined, dir = undefined) {
	dist ??= point_distance(x, y, npc.x, npc.y);
	
	if(dist > influenceRadius) { // some types of influence won't use this check (if out of range no effect, they will have minimums instead of maxes or never fall off or whatever idk)
		return 0; // not in range, ergo no effect
	}
	
	dir ??= point_direction(x, y, npc.x, npc.y);
	
	var _influence = 0; 
	var _dirPortion = 1;
	var _distPortion = 1;
	
	if(directionMatchType == 1) { //(type 0 is always full effect, this is probably default)
		if(abs(angle_difference(dir, influenceDirection)) < influenceDirectionRange) {
			_dirPortion = 1; // just has to be in the cone to get full effects
		}
	} else if(directionMatchType == 2) {
		var _dirOff = abs(angle_difference(dir, influenceDirection));
		
		_dirPortion = 1 - (_dirOff / influenceDirectionRange); // more effect the more in range it is
	}
	
	if(dist < influenceConsequenceRadius) {
		_distPortion = influenceDirectContact;
	} else {
		_distPortion = 1 - (dist / influenceRadius);
	}
	
	_influence = _distPortion * _dirPortion; // do the total here, if I need to add to this it'll be better to have a separate line for it, wonder why that would be though
	
	var _influenceArray = array_create(seekDirections);
	for(var _i = 0; _i < seekDirections; _i++) {
		_influenceArray[_i] = influenceStrength * _influence * (influenceRangeMax - (abs(angle_difference(dir, _i * seekDirectionIncrement)) / 180)) * influenceRangeOfValue;
	}

	
	return _influenceArray;
}