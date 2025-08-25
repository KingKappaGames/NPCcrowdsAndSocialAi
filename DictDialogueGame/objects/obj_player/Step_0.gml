if(live_call()) { return live_result }

audio_listener_set_position(0, x, y, 0);

depth = -y;
followingLight.x = x;
followingLight.y = y;
followingLight.depth = depth;
followingLight.persistent = true;

if(instance_exists(heldItem)) {
	var _speed = point_distance(0, 0, xChange, yChange);
	
	heldItem.x = x;
	heldItem.y = y - 20;
	heldItem.y += dsin(current_time * .3 * (_speed + 1)) * 10 * (_speed + 1); // jostle more and faster with speed
	
	if(keyboard_check_released(ord("B"))) { // drop
		heldItem = noone;
	}
} else {
	if(keyboard_check_released(ord("B"))) { // pick up nearby item
		var _nearest = instance_nearest(x, y, obj_itemDrop);
		if(instance_exists(_nearest)) {
			if(point_distance(x, y, _nearest.x, _nearest.y) < 70) {
				heldItem = _nearest;
			}
		}
	}
}

if(!instance_exists(obj_dialogueManager.speakerId)) {
	if(keyboard_check_pressed(vk_shift)) {
		if(stamina > 0) {
			sprinting = true;
		}
	} else if(keyboard_check_released(vk_shift)) {
		sprinting = false;
	}
	
	xChange += (keyboard_check(ord("D")) - keyboard_check(ord("A"))) * (moveSpeed + sprinting * moveSpeed * 1.2);
	yChange += (keyboard_check(ord("S")) - keyboard_check(ord("W"))) * (moveSpeed + sprinting * moveSpeed * 1.2); 
	
	if(sprinting) {
		stamina -= 3;
		if(stamina <= 0) {
			sprinting = 0;
		}
	}
}

x += xChange;
y += yChange;
xChange *= speedDecay;
yChange *= speedDecay;

stamina = clamp(stamina + 1, 0, staminaMax);

if(keyboard_check_released(ord("1"))) { // agree
	reaction = 1;
}
if(keyboard_check_released(ord("2"))) { // disagree
	reaction = 2;
}
if(keyboard_check_released(ord("3"))) { // anger
	reaction = 3;
}
if(keyboard_check_released(ord("4"))) { // doubt (question?)
	reaction = 4;
}
if(keyboard_check_released(ord("5"))) { // laugh
	reaction = 5;
}

if(keyboard_check_released(vk_f9)) {
	instance_create_depth(mouse_x ,mouse_y, depth, obj_monster);
}

if(reaction != 0) {
	var _subject = instance_nearest(x, y, obj_npc);
	if(instance_exists(_subject)) {
		if(point_distance(x, y, _subject.x, _subject.y) < 150) {
			_subject.judgeComment(reaction);
		}
	}
	reaction = 0;
}

if(keyboard_check_released(ord("H"))) {
	var _hero = instance_nearest(mouse_x, mouse_y, obj_npc);
	if(instance_exists(_hero)) {
		if(point_distance(x, y, mouse_x, mouse_y) < point_distance(_hero.x, _hero.y, mouse_x, mouse_y)) {
			_hero = id;
		}
		
		_hero.leader = true;
		var _agroList = ds_list_create();
		collision_circle_list(mouse_x, mouse_y, 500, obj_npc, false, true, _agroList, true);
		var _count = ds_list_size(_agroList);
		for(var _i = 0; _i < _count; _i++) {
			var _enemy = _agroList[| _i];
			if(_enemy != _hero) {
				_enemy.followingPoint = true;
				_enemy.followingId = _hero;
			}
		}
		ds_list_destroy(_agroList);
	}
}

if(keyboard_check_released(ord("N"))) {
	script_createNpc(obj_npc, mouse_x, mouse_y);
}

if(keyboard_check_released(ord("R"))) {
	with(obj_npc) {
		followingId = noone;
		followingPoint = false;
		pathMoving = false;
		leader = 0;
	}
	
	leader = false;
}


//if(keyboard_check_released(ord("R"))) {
//	room_goto(Room2);
//}

if(keyboard_check_released(ord("P"))) {
	with(obj_npc) {
		with(obj_npc) {
			if(id != other) {
				var _arrow = instance_create_layer(other.x, other.y, "Instances", obj_debugArrow);
				_arrow.targetX = x;
				_arrow.targetY = y;
				//_arrow.feeling = script_getAllegianceJudgement(objectAllegiance, other.objectAllegiance);
				_arrow.feeling = script_npcJudgeOtherPersonality(id, other.id);
			}
		}
	}
}

if(mouse_check_button_pressed(mb_left)) {
	var _directId = instance_nearest(mouse_x, mouse_y, obj_npc);
	if(instance_exists(_directId)) {
		directId = _directId;
	}
}

if(mouse_check_button_released(mb_left)) {
	if(instance_exists(directId)) {
		directId.pathMoving = false;
		directId.followingPoint = true;
		directId.followingId = noone;
		directId.followPointX = mouse_x;
		directId.followPointY = mouse_y;
	}
	
	directId = noone;
}


camera_set_view_pos(view_camera[0], x - camera_get_view_width(view_camera[0]) / 2, y - camera_get_view_height(view_camera[0]) / 2);

//if(keyboard_check_released(vk_control)) {
//	msg(current_time);
//	var _dist = path_get_length(path_mainLoop);
//	repeat(100000) {
//		script_getClosestPathPosition(path_mainLoop, x, y, 80, _dist, 30);
//	}
//	msg(current_time);
//}

//all 10k repeats unless specified (ms)
//1100 - 1000 non dist given vm 20 prec
//800 dist given vm 20 prec
//30 auto complete on first point vm 20 prec
//2100 non dist given 80 prec vm 100k repeats
//2100 dist given 80 prec vm 100k rep (this to me means passsing in dist means nothing) VM and more repeats than an entire session would have and it's not even differntiable with 10 ms...
//250 dist given 20 prec YYC
//125 dist given 40 prec YYC
//125? dist not given 40 pec YYC (dist given seems to do nothing for fps, maybe it's stored in the asset?)
//600 dist given 80 prec YYC 100k reps