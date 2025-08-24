event_inherited();

drawAngle = irandom(360);

alignment = choose(0, 1);

smoke = part_type_create();
part_type_life(smoke, 90, 150);
part_type_size(smoke, .02, .04, .005, 0);
part_type_shape(smoke, pt_shape_square);
part_type_direction(smoke, 0, 360, 0, 0);
part_type_speed(smoke, 0, .2, -.005, 0);
part_type_gravity(smoke, .015, 90);
part_type_color_mix(smoke, c_grey, c_ltgrey);

part = part_type_create();
part_type_life(part, 45, 90);
part_type_size(part, .1, .4, -.01, .1);
part_type_shape(part, pt_shape_square);
part_type_direction(part, 0, 360, 0, 12);
part_type_speed(part, .2, .5, -.01, 0);
part_type_gravity(part, .02, 90);

part_type_blend(part, true); // mmmmmM

if(alignment == 0) {
	part_type_color1(part, #3f0338);
} else {
	part_type_color1(part, #bb4411);
}

danger = .9;

range = irandom_range(30, 50) + irandom_range(20, 30);

alive = true;
destroyable = true;

radiantDestroy = function() {
	part_particles_create(global.sys, x, y, smoke, 50);
	instance_destroy();
}