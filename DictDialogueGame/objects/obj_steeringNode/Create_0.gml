if(live_call()) { return live_result }

influence = random_range(-1, 1);
influenceDirectContact = influence * 2;

influenceRadius = 200;
influenceConsequenceRadius = 40;

influenceDirection = 0;
influenceDirectionRange = 0;
directionMatchType = 0; // 0 is no preference, 1 is if in range full effect, 2 is more preference for more aligned

influenceShape = 0; // uhhhh, 0 is move away? I guess these should be indexes for shape masks..?
//have a way to specify the impact of the influence, like some will pull more the closer you are, some will pull to a certain range then stop, some will effect you more the further you are

getInfluence = function(npc, dist = undefined, dir = undefined) {
	dist ??= point_distance(x, y, npc.x, npc.y);
	
	if(dist > influenceRadius) { // some types of influence won't use this check (if out of range no effect, they will have minimums instead of maxes or never fall off or whatever idk)
		return 0; // not in range, ergo no effect
	}
	
	dir ??= point_direction(x, y, npc.x, npc.y);
	
	var _influence = 0; 
	var _dirPortion = 1;
	var _distPortion = 1;
	
	if(directionMatchType == 1) {
		if(abs(angle_difference(dir, influenceDirection)) < influenceDirectionRange) {
			_dirPortion = 1;
		}
	} else if(directionMatchType == 2) {
		var _dirOff = abs(angle_difference(dir, influenceDirection));
		
		_dirPortion = 1 - (_dirOff / influenceDirectionRange);
	}
	
	if(dist < influenceConsequenceRadius) {
		_distPortion = influenceDirectContact;
	} else {
		_distPortion = 1 - (dist / influenceRadius);
	}
	
	_influence = _distPortion * _dirPortion; // do the total here, if I need to add to this it'll be better to have a separate line for it, wonder why that would be though
	
	var _influenceArray = array_create(seekDirections);
	if(influence > 0) {
		for(var _i = 0; _i < seekDirections; _i++) {
			_influenceArray[_i] = influence * _influence * (1 - (abs(angle_difference(dir, _i * seekDirectionIncrement)) / 180));
		}
	} else {
		var _flippedInfluence = abs(influence);
		for(var _i = 0; _i < seekDirections; _i++) {
			_influenceArray[_i] = _flippedInfluence * _influence * (abs(angle_difference(dir, _i * seekDirectionIncrement)) / 180);
		}
	}
	
	return _influenceArray;
}