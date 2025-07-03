if(random(1) < size / 20) {
	var _sizeMult = size * .125;
	part_type_size(global.waterTrail, .5 * _sizeMult, 1 * _sizeMult, 0, 0);
	var _range = size * .75;
	part_particles_create_color(global.sys, x + irandom_range(-_range, _range), y - height * .7 + irandom_range(-_range, _range), global.waterTrail, c_white, 1);
}

if(height <= 0) {
	var _fallingMult = sqrt(abs(heightChange));
	script_createWaterSplash(x, y, spr_waterSplashIsometric, 0, 0, size * .06 * _fallingMult, size * .025 * _fallingMult,, .25 + size * .1, max(25 - size - _fallingMult * .5, 5));
	
	part_type_life(global.waterSplash, 3 * sqrt(_fallingMult), 9 * sqrt(_fallingMult) * sqrt(size));
	part_type_size(global.waterSplash, size * .3, 1.5 * size, 0, 0);
	part_type_speed(global.waterSplash, .2 + _fallingMult * .1, .2 + _fallingMult * .3 * power(size, .45), 0, 0);
	part_particles_create_color(global.sys, x, y, global.waterSplash, c_white, irandom_range(size * sqrt(_fallingMult) * .5, (power(size, 1.4) * _fallingMult) * .8));
	
	//if(size > 12) {
		//script_createWaterSplash(x, y, spr_waterSplashDecal, 0, -1000, sqrt(size) * .5, sqrt(size) * .5,, .5, 1);
	//}
	
	if(makeChildren) {
		if(size > 11) {
			audio_play_sound(snd_waterSplash, 0, 0);
		}
		
		var _childCount = floor(power(size, .75) * max(_fallingMult - 1, 0) * random_range(.75, 2.1));
		
		_fallingMult = max(_fallingMult - 1, 0) * .9; // speed adjuster at this point
		
		repeat(_childCount) {
			 script_createWaterProjectile(x, y, 1, random_range(size * .1, size * .4), random_range(-_fallingMult - .2, _fallingMult + .2), random_range(-_fallingMult - .2, _fallingMult + .2), random_range(.3, abs(heightChange * .5 + 1)), gravityStrength,,, false); // don't branch into more and more children (you could say this is to do with solids producing more of a deformation than liquids, when rocks fall they create these pires of pressure that causes splash, when water falls into water it just fragments over the other water and doesn't cause any crazy splashing.. hm.
		}
	}
	
	
	instance_destroy();
} else {
	x += xChange;
	y += yChange;
	height += heightChange;
	
	heightChange -= gravityStrength;
}