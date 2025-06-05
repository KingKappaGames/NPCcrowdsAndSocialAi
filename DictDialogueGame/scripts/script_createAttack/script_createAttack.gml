function script_createAttack(xx, yy, dir, speed, duration, damage, knockback, hitRadius, hitType) {
	var _swing = instance_create_depth(xx, yy, depth, obj_attackSwing);
	_swing.damage = damage;
	_swing.dir = dir;
	_swing.spd = speed;
	_swing.duration = duration;
	_swing.durationMax = duration;
	_swing.knockback = knockback;
	_swing.radius = hitRadius;
	_swing.hitType = hitType;
	
	_swing.image_angle = dir - 90;
}