if(live_call()) { return live_result }
	
event_inherited();
	
//if(keyboard_check_released(vk_f2)) {
	//scribble_anim_wave(1.8, .25, .1);
//}

if(inDialogue) { // custom dialogue (not chatterbox)
	if(dialogueType == E_dialogueTypes.dict) {
		if(keyboard_check_released(vk_escape)) {
			var _player = instance_nearest(x,y, obj_player);
			if(instance_exists(_player)) {
				talkDictionary();
			}
		}
	} else if(dialogueType == E_dialogueTypes.chatterbox) {
		if(instance_exists(dialoguePartner)) {
			if(point_distance(dialoguePartner.x, dialoguePartner.y, x, y) > interactionRange) { // close if speaker too far away
				script_chatterboxDialogueShutdownChat();
			} else {
				var _target = global.player; // well now that I've added this little layer this needs cleaned up but it works nicely, I think?
				if(keyboard_check_released(vk_space) || mouse_check_button_released(mb_left) || (emotionReactionsAvaialble && (keyboard_check_released(ord("7")) || keyboard_check_released(ord("8")) || keyboard_check_released(ord("9"))))) {
					script_chatterboxDialogueDoInteraction(_target);
				}
			}
		} else {
			if(text != -1) {
				script_chatterboxDialogueShutdownChat();
			}
		}
	}
} else { // not in (dynamic - non chatterbox) dialogue		
	// from here on is basically just free control, no formal dialogue interaction and no speaker id to react to so there's no dialogue happening, I need to clean this though
	randomCommentTimer--;
	if(randomCommentTimer <= 0) {
		sayRandomComment();
	}
		
	if(keyboard_check_released(ord("E"))) {
		var _player = instance_nearest(x,y, obj_player); // same s different inputs
		if(instance_exists(_player)) {
			if(point_distance(x, y, _player.x, _player.y) < 100) {
				talkDictionary();
			}
		}
	}
	
	if(pathMoving) {
		#region moving on a path
		moveDelay--;
		if(moveDelay <= 0) {
			xChange = 0;
			yChange = 0;
			if(irandom(moveStartChance) == 0) {
				var _speed = random(moveSpeed);
				var _pointDir = point_direction(x, y, pathGoalX, pathGoalY);
			
				xChange = dcos(_pointDir) * moveSpeed;
				yChange = -dsin(_pointDir) * moveSpeed;
				moveDelay = irandom_range(60, 420);
			}
		} else {
			if(point_distance(x, y, pathGoalX, pathGoalY) < pathGoalRadius) {
				if((path_position == 1 && pathIncrement > 0) || (path_position == 0 && pathIncrement < 0)) { // if moving towards end, check this after set to let the instance get to the end before marking it
					if(!path_get_closed(pathCurrent) || (current_time - pathCurrentStartTime > 5000)) { // eh..? A circular path must be followed for at least 2.5 seconds to break on loop... this is a janky way to prevent jumping back and forth between starts and close points... Remake this at some point I guess I don't know.
						var _pathInfo = script_chooseNextPath(pathCurrent, path_position, id);
						startPathMovement(_pathInfo[0], _pathInfo[1], _pathInfo[2]);
					} else { // failed circular path
						path_position = 1 - path_position;
					}
				}
			
				var _prevPathPos = path_position;
			
				path_position += (pathIncrement) / pathCurrentLength; // move 20 pixels before re-establishing point
			
				if(path_position > 1) {
					path_position = 1;
				} else if(path_position < 0) { //.this is goal setting so don't loop, it wont affect speed just logic
					path_position = 0;
				}
				
				var _pointCrossed = pathPointOfInterestPassed(_prevPathPos, path_position);
				if(_pointCrossed != -1) {
					var _pathInfo = script_chooseNextPath(pathCurrent, _pointCrossed, id);
					startPathMovement(_pathInfo[0], _pathInfo[1], _pathInfo[2]);
					
					script_createSpeechBubble(id, "shadow", x, y, "Crossed", 80, 30, .1, curve_SBemerge, curve_SBgrow);
				} else {
					//if crossed any points of interest (branches, maybe pauses or something else) then recheck your path setting with (choose next path))
					pathGoalX = path_get_x(pathCurrent, path_position);
					pathGoalY = path_get_y(pathCurrent, path_position);
			
					var _pointDir = point_direction(x, y, pathGoalX, pathGoalY);
			
					xChange = dcos(_pointDir) * moveSpeed;
					yChange = -dsin(_pointDir) * moveSpeed;
				}
			}
		}
		#endregion
	} else if(followingPoint) {
		//if(irandom(50) == 0) {
		//	var _agroList = ds_list_create();
		//	collision_circle_list(x, y, 1600, obj_npc, false, true, _agroList, true);
		//	var npcAroundCount = ds_list_size(_agroList);
		//	for(var _i = 0; _i < npcAroundCount; _i++) {
		//		var _enemy = _agroList[| _i];
		//		if(_enemy.friendly != friendly && _enemy.alive) {
		//			agroId = _enemy;
		//		}
		//	}
		//}
		
		if(irandom(5) == 0) {
			ds_list_clear(npcAroundList)
			collision_circle_list(x, y, 200, obj_npc, false, true, npcAroundList, true); // get nearby npcs
			npcAroundCount = ds_list_size(npcAroundList);
			
			var _monster = instance_nearest(x, y, obj_monster);
			var _monsterDist = -1;
			if(_monster != noone) {
				_monsterDist = point_distance(x,y, _monster.x, _monster.y);
				followPointX = _monster.x;
				followPointY = _monster.y;
				
				var _monsterDir = point_direction(x,y, _monster.x, _monster.y);
				xChange += dcos(_monsterDir) * .35;
				yChange -= dsin(_monsterDir) * .35;
				
				if(attackTimer <= 0) {
					if(_monsterDist < 60) {
						attack(point_direction(x,y, _monster.x, _monster.y), 20);
					}
				}
			}
			if(_monsterDist == -1) {
				if(instance_exists(followingId)) {
					followPointX = followingId.x + followingId.xChange * 14;
					followPointY = followingId.y + followingId.yChange * 14;
				} else if(followingId != noone) {
					followingId = noone;
					followingPoint = false;
				}
			}
				
			var _dist = point_distance(x, y, followPointX, followPointY);
			var _dir = point_direction(x, y, followPointX, followPointY);
			
			var _approachSpeed = clamp(_dist / 70 - 1, -.25, 12);
			
			if(_approachSpeed < 0) {
				_approachSpeed = _approachSpeed * 1;
				if(followingId == noone) {
					followingPoint = false; // close enough to cancel follow of point
				}
			} else {
				_approachSpeed = clamp((_approachSpeed - 1.5) / 7, 0, 2.2);
			}
			
			xChange += dcos(_dir) * _approachSpeed;
			yChange += -dsin(_dir) * _approachSpeed;
				
			#region avoiding stuff (janky?)
			var _avoiding = true; // as you go up check the avoid vs approach difference to see if you should check for this
		
			
			if(npcAroundCount > 0) {
				#region variable setting
				var _approachX = 0;
				var _approachY = 0;
			
				var _avoidXChange = 0;
				var _avoidYChange = 0; // speeds to add up
				
				var _avoidDir = 0;
				var _avoidDist = 0;
				
				var _enemy = noone;
				var _enemyX = 0;
				var _enemyY = 0;
				#endregion
				
				for(var _i = 0; _i < npcAroundCount; _i++) {
					_enemy = npcAroundList[| _i];
					_enemyX = _enemy.x;
					_enemyY = _enemy.y;
					
					_approachX += _enemyX;
					_approachY += _enemyY;
					
					if(_avoiding) {
						_avoidDist = point_distance(_enemyX, _enemyY, x, y);
						if(_avoidDist < 26) {
							_avoidDir = point_direction(_enemyX, _enemyY, x, y);
							
							_avoidXChange += 22 * dcos(_avoidDir) / max(power(_avoidDist, .75), 2);
							_avoidYChange -= 22 * dsin(_avoidDir) / max(power(_avoidDist, .75), 2);
						} else {
							_avoiding = false;
						}
					}
				}
		
				_approachX /= npcAroundCount;
				_approachY /= npcAroundCount;
				
				_avoidXChange /= npcAroundCount;
				_avoidYChange /= npcAroundCount; // push enemies away with normalized average / 100 for distance to speed
				
				xChange += clamp(_avoidXChange, -.7, .7);
				yChange += clamp(_avoidYChange, -.7, .7);
				
				var _approachDir = point_direction(x, y, _approachX, _approachY);
				var _approachDist = point_distance(x, y, _approachX, _approachY); // move towars center of mass
				xChange += dcos(_approachDir) * (1 - (_approachDist / 200)) / 110;
				yChange -= dsin(_approachDir) * (1 - (_approachDist / 200)) / 110;
			}
			#endregion
			
			if(instance_exists(followingId) && object_is_ancestor(followingId.object_index, obj_radiantObject) && point_distance(followingId.x, followingId.y, x, y) > followingId.range * .6) {
				xChange += dcos(_dir) * .3; // push towards radiant goal, this is all supposed to be handled by steering behavior stuff but ehhhhhh
				yChange -= dsin(_dir) * .3;
			}
		}
	} else { // no goal
		#region random moving
		moveDelay--;
		if(moveDelay <= 0) {
			xChange = 0;
			yChange = 0;
			if(irandom(moveStartChance) == 0) {
				var _dir = 0;
				if(irandom(3) == 0) {
					var _house = instance_nearest(x, y, obj_house);
					if(instance_exists(_house)) {
						_dir = point_direction(x, y, _house.x, _house.y) + irandom_range(-10, 10);
					}
				} else {
					_dir = irandom(360);
				}
			
				var _speed = random(moveSpeed);
			
				xChange = dcos(_dir) * _speed;
				yChange = -dsin(_dir) * _speed;
				moveDelay = irandom_range(60, 420);
			}
		}
		#endregion
	}
	
	attackTimer--;
	
	if(irandom(30) == 0) {
		var _monster = instance_nearest(x, y, obj_monster);
		if(instance_exists(_monster) && point_distance(x,y, _monster.x, _monster.y) < 150) {
			followingPoint = true;
			followingId = _monster;
		}
	}
	
	if(irandom(60) == 0) {
		if(instance_exists(followingId) && object_is_ancestor(followingId.object_index, obj_radiantObject)) {
			if(point_distance(followingId.x, followingId.y, x, y) < followingId.range ) {
				followingId.radiantDestroy();
			}
		} else {
			var _radiant = instance_nearest(x, y, obj_radiantObject);
			if(instance_exists(_radiant) && (abs(_radiant.alignment - alignment) > .35) && point_distance(x, y, _radiant.x, _radiant.y) < _radiant.range * 4 + 250) {
				followingPoint = true;
				followingId = _radiant;
			}
		}
	}
	
	x += xChange;
	y += yChange;
	xChange *= speedDecay;
	yChange *= speedDecay;
	depth = -y;
	
	if(dialogueValueCollection != noone) { // enter chatterbox dialogue from no dialogue
		var _target = global.player; // well now that I've added this little layer this needs cleaned up but it works nicely, I think?
		if(keyboard_check_released(vk_space) || mouse_check_button_released(mb_left) || (emotionReactionsAvaialble && (keyboard_check_released(ord("7")) || keyboard_check_released(ord("8")) || keyboard_check_released(ord("9"))))) {
			if(point_distance(x, y, _target.x, _target.y) < interactionRange) { // only player can really start a dialogue this way..
				script_chatterboxDialogueDoInteraction(_target);
			}
		}
	}
}



if(keyboard_check_released(ord("P"))) {
	startPathMovement(path_mainLoop, 1, script_getClosestPathPosition(path_mainLoop, x, y, 50, -1, 100));
}

if(keyboard_check_released(ord("L"))) {
	followingPoint = true;
	followPointX = mouse_x;
	followPointY = mouse_y;
}

var _item = instance_nearest(x, y, obj_itemDrop);
if(instance_exists(_item)) {
	if(point_distance(x, y, _item.x, _item.y) < 50) {
		var _opinion = script_npcJudgeItem(id, _item.item);
		image_blend = make_color_rgb((1 - _opinion) * 255, _opinion * 255, 0);
	}
}

emotionOpinion = lerp(emotionOpinion, .5, .0003);
emotionMood = lerp(emotionMood, .5, .0008);
emotionTrust = lerp(emotionTrust, .5, .0005);
emotionAnger = lerp(emotionAnger, .5, .0012);
emotionFear = lerp(emotionFear, .5, .0009);
emotionEnergy = lerp(emotionEnergy, .5, .0003);

//todo flash point social moments

/*
This is finicky hard /: AI steering behaviors and group movement

I've been trying to put some kind of group movement system together for last couple days on and off, as of now I'm just using a check for surrounding creatures and pushing away from their averages. They follow the leader and push each other away. That's all. Maybe I should do something more sophisticated? It's hard to balance approaching the leader and avoiding in a way that doesn't just lead to the most tightly packed groups possible. I'd prefer if they followed as best they could but just stood around idle when the crowds got too packed. It looks very stupid for friendly people to be packing together like this. I could try to force that but the system might fall apart and become spaghetti code so the problem is finding an elegant solution to all the problems at once. Perhaps a way to cancel out desires when counter desires are in play, that's getting more into like directional goal tracking which is more performance heavy but doable... HMMMMMMMM

I've been trying to put together some crown behaviors and more intelligent ai spacing as a mini project for another game (or two?) and it's uh... Going... But I wanted to say, if anyone wanted to get in touch and work on steering behaviors and group ai together either in a shared project or just chatting about it hit me up, I'm still only a couple days into this but I'll probably be messing with it for a few weeks here and there if I had to guess. I've always wanted to do this kind of thing. It's hard to get the balance right for it. 🤔  https://youtu.be/UWNXz3QlbCA