//enter, leave, step, draw, customNames
//add("name", {

//}) // behaviors and functions (named with leave, enter, step, ect)
sprite_index = spr_ghoul;

xChange = 0;
yChange = 0;
moveSpeed = .3;

Health = 30;
weaponHeld = 0; // something other than 0 is weapon
attackTimer = 0;
target = noone;

wanderTime = 0;

fsm = new SnowState("idle");
fsm.add("idle", {
	step: function() {
		if(irandom(30) == 0) {
			var _target = instance_nearest(x, y, obj_npc);
			if(instance_exists(_target)) {
				if(point_distance(x, y, _target.x, _target.y) < 300) {
					target = _target;
					fsm.change("fight");
				}
			}
		} else if(irandom(240) == 0) {
			fsm.change("wander");
		}
	}
})
fsm.add("fight", {
	step: function() {
		var _target = instance_nearest(x, y, obj_npc);
		if(instance_exists(_target)) {
			var _dir = point_direction(x,y,_target.x,_target.y);
			var _dist = point_distance(x,y,_target.x,_target.y);
			xChange += dcos(_dir) * moveSpeed;
			yChange -= dsin(_dir) * moveSpeed;
			xChange *= .92;
			yChange *= .92;
			
			if(_dist < 60) {
				xChange *= .99;
				yChange *= .99;
				
				if(attackTimer > 0) {
					attackTimer--;
				} else {
					attack(_dir, _dist);
				}
			}
		} else {
			fsm.change("idle");
		}
	}
});
fsm.add("wander", {
	step: function() {
		if(irandom(60) == 0) {
			var _target = instance_nearest(x, y, obj_npc);
			if(instance_exists(_target)) {
				if(point_distance(x, y, _target.x, _target.y) < 200) {
					target = _target;
					fsm.change("fight");
					return;
				}
			}
		}

		wanderTime--;
		if(wanderTime <= 0) {
			if(irandom(2) == 0) {
				xChange = irandom_range(-2, 2);
				yChange = irandom_range(-2, 2);
				wanderTime = irandom_range(60, 300);
			} else {
				fsm.change("idle");
			}
		}
	}
});

bloodPart = part_type_create();
part_type_shape(bloodPart, pt_shape_square);
part_type_size(bloodPart, .09, .14, -.0045, 0);
part_type_life(bloodPart, 16, 25);
part_type_color2(bloodPart, #b20000, #ed1212);
part_type_direction(bloodPart, 0, 360, 0, 0); // changed changed with use
part_type_speed(bloodPart, 2, 6.5, -.09, 0); // changed changed with use
part_type_gravity(bloodPart, .08, 270)
part_type_orientation(bloodPart, 0, 360, 0, 0, 0);

hit = function(dir, knockback, damage) {
	Health -= damage;
	xChange += dcos(dir) * knockback;
	yChange -= dsin(dir) * knockback;
	
	part_particles_create(global.sys, x, y, bloodPart, 10 + irandom(10));
	
	if(Health <= 0) {
		part_particles_create(global.sys, x, y, bloodPart, 20 + irandom(20));
		instance_destroy();
	}
}

attack = function(dir, dist) {
	var _attackDist = min(dist, 20);
	script_createAttack(x + dcos(dir) * _attackDist, y - dsin(dir) * _attackDist, dir, 1, 20, 1, 1, 25, obj_npc);
	
	attackTimer = 30 + irandom(30);
}