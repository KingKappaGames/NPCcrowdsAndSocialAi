if(live_call()) { return live_result }

depth -= 3;

#region npc values for character info


residence = -1; // specific city or village, not house, not region (could be none / travellor maybe?)
homeland = -1;
gender = -1;
age = -1;
objectAllegiance = -1;

occupation = -1;
religion = -1;
wealth = -1;
status = -1;
alignment = -1;
criminality = -1;
magicStrength = -1;
magicField = -1;
powerLevel = -1;

extraversion = -1;
selfWorth = -1;
personality = -1;
trust = -1;
energyPersonality = -1; // this would be vitality/how spry they were, age is a big impact but also magic and history
joy = -1;
curiosity = -1;
combativeness = -1;
knowledgeGeneral = -1;

speedValue = -1;
weightValue = -1;
keenness = -1;

script_npcGeneratePersonality();
#endregion

inDialogue = false;
dialogueValid = false;

randomCommentTimer = 0;
randomCommentTimerMax = 600;
comment = "";
playerCommentRange = 140;

topicsDiscussed = [];
expectingAnswer = false;
frustration = 0;
fear = 0;
friendliness = 0;
energy = 0;

moveDelay = 0;
moveStartChance = 120;

pathMoving = 0;

xChange = 0;
yChange = 0;
moveSpeed = 2.8;
speedDecay = .98;

followingPoint = false;
followPointX = 0;
followPointY = 0;
followingId = noone;
leader = false;
npcAroundList = ds_list_create();
npcAroundCount = 0;

pathCurrent = noone;
pathGoalX = 0;
pathGoalY = 0;
pathGoalRadius = 15;
pathIncrementBase = 20;
pathIncrement = pathIncrementBase; // pixels (negative or positive)

pathPredictDist = 50;

pathCurrentStartTime = current_time;

pathPOIs = [];

talk = function() {
	inDialogue = !inDialogue;
	if(inDialogue) {
		obj_dialogueManager.startDialogue(id);
		xChange = 0;
		yChange = 0;
	} else {
		obj_dialogueManager.endDialogue();
		moveDelay = irandom_range(20, 180);
		moveStartChance = 30;
	}
}

sayRandomComment = function() {
	live_auto_call
	randomCommentTimer = irandom_range(randomCommentTimerMax / 2, randomCommentTimerMax);
	var _player = instance_nearest(x,y, obj_player); // same s different inputs
	if(instance_exists(_player)) {
		if(point_distance(_player.x, _player.y, x, y) < playerCommentRange) {
			if(irandom(1) == 0) {
				xChange = 0;
				yChange = 0;
				moveDelay = irandom_range(80, 140);
				moveStartChance = 30;
			}
			comment = script_generatePlayerComment(); // player focused comment
			script_createSpeechBubble(x, y - 180, comment[0], 190);
			exit;
		}
	}
	
	comment = script_generateSelfComment(); // non player focused comment
	script_createSpeechBubble(x, y - 180, comment[0], 170);
}

judgeComment = function(judgment) { // agree, diagree, anger, doubt, laugh
	live_auto_call
	with(obj_speechBubble) {
		if(sourceId == other.id) {
			instance_destroy();
		}
	}
	if(is_array(comment)) {
		comment = comment[judgment]; // select actual comment from comment info
		script_createSpeechBubble(x, y - 180, is_array(comment) ? comment[0] : comment, 190); // pass either the first index if it is an array or the whole thing if not
	} else {
		comment = "..."; // no more tree to follow..
		script_createSpeechBubble(x, y - 180, comment, 190);
	}
	
	randomCommentTimer += 300;
	
	if(irandom(3) != 0) {
		xChange = 0;
		yChange = 0;
		moveDelay = irandom_range(80, 140);
		moveStartChance = 30;
	}
}


///@desc Increment can be negative! -1 for no position change, -2 for calculate closet point to goal path
startPathMovement = function(path = pathCurrent, pathFollowIncrement = pathIncrement, position = path_position) {
	if(path_exists(path)) {
		pathMoving = true;
		pathCurrent = path;
		pathCurrentStartTime = current_time; // game time (switch)
	
		pathCurrentLength = path_get_length(path);
		
		pathIncrement = pathIncrementBase * pathFollowIncrement;
		
		if(position != -1 && position != -2) { // none key word, set position
			path_position = position;
		} else if(position == -2) { // if key word -2 calculate position
			path_position = script_getClosestPathPosition(pathCurrent, x, y, 30, pathCurrentLength, 40) + (sign(pathIncrement) * (pathPredictDist / pathCurrentLength)); // add prediction dist to point of entry to simulate cutting the paths a little in the direction you're headed, you don't just cut straight to the cloest point when switching paths in real life, you take the most direct path
		} // else (-1) keep old position
		
		pathGoalX = path_get_x(pathCurrent, path_position);
		pathGoalY = path_get_y(pathCurrent, path_position);
		
		pathPOIs = script_getPathPOIs(pathCurrent);
		
		var _pointDir = point_direction(x, y, pathGoalX, pathGoalY);
		xChange = dcos(_pointDir) * moveSpeed;
		yChange = -dsin(_pointDir) * moveSpeed;
	}
}

///@desc Given a length of path did you pass over a point of interest? If so this will return the exact position of the point of interest so you can check with it, otherwise returns -1
pathPointOfInterestPassed = function(startPos, endPos) {	
	var _genHold = 0;
	
	if(startPos > endPos) {
		_genHold = startPos;
		startPos = endPos; // flip the two points if start is more than end, this makes checking the range easier
		endPos = _genHold;
	}
	
	if(pathPOIs != -1) {
		var _poiCount = array_length(pathPOIs);
		
		//check for passing over pois
		for(var _poi = 0; _poi < _poiCount; _poi++) {
			_genHold = pathPOIs[_poi];
			
			if(_genHold > startPos && _genHold < endPos) {
				return _genHold;
			}
		}
		
		return -1;
	} else {
		return -1;
	}
}

stopPathMovement = function() {
	pathMoving = false;
}

image_blend = make_color_rgb(irandom(255), irandom(255), irandom(255));