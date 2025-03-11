// -2 returned means find closest point yourself, -1 means no position change
// [pathID, pathDirection, pathPosition(or code)]

// paths have arrays of poi's that represent breaks or splits or stopping points, when an instance passes one of those points they run a decision script to decide to split or stay or pause ect.
// info would be pathInfo = [poiPos1, poiPos2, poiPos3, poiPos4] This represents the places to run the switch scripts but otherwise this doesn't do any logic, this script (chooseNextPath) will do all the logic but it needs to know when to run.
// would you get these poi's from a script? Like a get pathPOI's() ? So you pass in path_main and it has a big if else and says ... if(path == path_main) ... return [.01, 

///@desc Given a path and the current position what paths should be available to follow now, it will also make some decisions based on the source id state (returns -1 for path position to mean no change in position)
function script_chooseNextPath(sourcePath, progress, sourceId = id){
	live_auto_call
	// add a function that takes every path and gets a list of positions of interest that trigger this change function and those points would go into an array that you would check for passing over to trigger
	if(room == Room1) {
		if(sourcePath == path_mainLoop) {
			if(progress == 1) {
				return [path_mainLoop, 1, 0];
			} else if(progress == 0) {
				return [path_mainLoop, -1, 1];
			} else if(progress > .97 || progress < .05) {
				return [path_upLeftDetour, choose(-1, 1), -2];
			} else if(progress > .74 && progress < .8) {
				return [path_leftDetour, choose(-1, 1), -2];
			} else if(progress > .35 && progress < .43) {
				return [path_bottomRightDetour, choose(-1, 1), -2];
			}
		} else if(sourcePath == path_upLeftDetour) {
			if(progress < .15 || progress > .85) {
				return [path_mainLoop, choose(-1, 1), -2];
			} else {
				return [path_upLeftDetour, choose(1, -1), -1];
			}
		} else if(sourcePath == path_bottomRightDetour) {
			if(progress < .05 || progress > .88) {
				return [path_mainLoop, choose(1, -1), -2];
			} else {
				return [path_bottomRightDetour, choose(1, -1), -1];
			}
		} else if(sourcePath == path_leftDetour) {
			if(progress < .15 || progress > .85) {
				return [path_mainLoop, choose(1, -1), -2];
			} else {
				return [path_leftDetour, choose(1, -1), -1];
			}
		}
	}
	
	return [sourcePath, choose(-1, 1), progress]; // this should not run but just to exit with something
}