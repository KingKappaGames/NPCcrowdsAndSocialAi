function script_createWaterProjectile(xx, yy, heightSet = 1, sizeSet = undefined, xChangeSet = random_range(0, 2), yChangeSet = random_range(0, 2), heightChangeSet = random_range(.5, 4), gravitySet = .07, blend = c_white, alpha = 1, makeChildrenSet = true) {
	
	sizeSet ??= max(irandom_range(-4, 7) + irandom_range(-4, 7) + irandom_range(-4, 7), 0);
	
	var _proj = instance_create_depth(xx, yy, -5000, obj_projectile);
	_proj.height = heightSet;
	_proj.size = sizeSet;
	_proj.xChange = xChangeSet;
	_proj.yChange = yChangeSet;
	_proj.heightChange = heightChangeSet;
	_proj.gravityStrength = gravitySet;
	_proj.image_blend = blend;
	_proj.image_alpha = alpha;
	_proj.makeChildren = makeChildrenSet;
}