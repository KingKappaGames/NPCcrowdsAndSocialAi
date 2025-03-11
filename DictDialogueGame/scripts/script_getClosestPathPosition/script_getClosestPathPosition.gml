///@param path The path to pass
///@param sourceX The x to check for closest points
///@param sourceY The y to check for closest points
///@param precision The amount of pixels to step through the path for checks, low precision = more checks
///@param pathLength The distance in pixels of the path, this will be auto calculated if not given but it's better to pass it in if it's convinient (pathCurrentLength in this proj)
///@param distMinimum The threshold distance to auto accept and return that point (vs the actual closest point) default to no auto accept threshold
function script_getClosestPathPosition(path, sourceX, sourceY, precision = 20, pathLength = -1, distMinimum = -1){
	if(path_exists(path)) {
		if(pathLength == -1) {
			pathLength = path_get_length(path); // if length not passed in set path here
		}
		
		precision /= pathLength; // turn pixels precision into path length % (decimal but yk)
		
		var _holdDist = 0;
		var _closestDist = 99999; // set up hold variables to store candidate closest points
		var _closestPoint = -1;
		for(var _i = 0; _i < 1 - precision; _i += precision) {
			_holdDist = point_distance(path_get_x(path, _i), path_get_y(path, _i), sourceX, sourceY); // how close to this point
			
			if(_holdDist < distMinimum) { // if acceptable already return this point
				return _i;
			} else if(_holdDist < _closestDist) { // if this point is better than our current best set this one to best (returns this at end if none acceptable)
				_closestDist = _holdDist;
				_closestPoint = _i;
			}
		}
		
		return _closestPoint;
	} else {
		return -1; // path does not exist
	}
}