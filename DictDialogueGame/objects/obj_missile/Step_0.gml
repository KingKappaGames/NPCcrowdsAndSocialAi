duration--;

x += xChange;
y += yChange;

xChange *= speedDecay;
yChange *= speedDecay;

var _fade = duration / durationMax;

light.radius = 150 * _fade;
light.intensity = _fade;
light.x = x;
light.y = y;
light.depth = depth - 1;

part_particles_create(global.sys, x, y, global.waterTrail, 1);

if(duration <= 0) {
	instance_destroy();
}