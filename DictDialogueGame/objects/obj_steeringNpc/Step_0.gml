if(live_call()) { return live_result }

timer++;

ds_list_clear(consideredInfluences);
var _consideredCount = collision_circle_list(x, y, 1500, obj_steeringNode, false, true, consideredInfluences, false);
goalArray = array_create(seekDirections, 0);

var _influence = 0;
var _influenceArray = 0;
for(var _influenceI = 0; _influenceI < _consideredCount; _influenceI++) {
	_influence = consideredInfluences[| _influenceI];
	
	_influenceArray = _influence.getInfluence(id);
	
	if(_influenceArray != 0) {
		for(var _i = 0; _i < seekDirections; _i++) {
			goalArray[_i] += _influenceArray[_i];
		}
	}
}




var _bestDir = 0;
var _bestVal = 0;
for(var _dirI = 0; _dirI < seekDirections; _dirI++) {
	if(goalArray[_dirI] > _bestVal) {
		_bestDir = _dirI * seekDirectionIncrement;
		_bestVal = goalArray[_dirI];
	}
}

//if(moveDir != _bestDir) {
	moveDir = _bestDir;
	xChange = clamp(dcos(moveDir) * moveSpeed  * _bestVal, moveSpeed * -3, moveSpeed * 3);
	yChange = clamp(-dsin(moveDir) * moveSpeed * _bestVal, moveSpeed * -3, moveSpeed * 3);
//}

x += xChange;
y += yChange;

if(mouse_check_button(mb_middle)) {
	if(point_distance(x, y, mouse_x, mouse_y) < 35) {
		x = mouse_x;
		y = mouse_y;
	}
}