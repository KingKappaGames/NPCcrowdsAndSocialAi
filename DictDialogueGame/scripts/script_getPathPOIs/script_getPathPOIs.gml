function script_getPathPOIs(path){
	if(path_exists(path)) {
		if(path == path_mainLoop) {
			return [.02, .39, .77];
		} else if(path == path_leftDetour) {
			return -1;
		} else if(path == path_bottomRightDetour) {
			return -1;
		} else if(path == path_upLeftDetour) {
			return -1;
		}// else if(path == path_
	}
	
	return -1; // if none other
}