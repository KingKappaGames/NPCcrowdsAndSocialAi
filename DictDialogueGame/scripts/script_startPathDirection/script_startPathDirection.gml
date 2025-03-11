///@desc This script starts the path at 0 or 1 position, no other options
///@param path The path to move on
///@param moveDirection The direction -1, or 1, to follow the path
function script_getPathBeginInfo(path, moveDirection = 0){
	if(moveDirection == 0) {
		moveDirection = choose(1, -1);
	}
	
	if(moveDirection >= 0) {
		return [path, moveDirection, 0]; // positive up path
	} else {
		return [path, moveDirection, 1]; // negative back down path
	}
}