part_particles_create(global.sys, x + irandom_range(-radius, radius), y + irandom_range(-radius, radius), shimmer, 1);

if(duration == round(durationMax)) {
	var _hits = collision_circle_list(x, y, radius, hitType, false, true, hitList, false);
	
	for(var _i = 0; _i < _hits; _i++) {
		hitList[| _i].hit(dir, knockback, damage);
	}
}
	
duration--;
if(duration <= 0) {
	instance_destroy();
}