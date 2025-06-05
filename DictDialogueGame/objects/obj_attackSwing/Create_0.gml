sprite_index = spr_sweep;

duration = 20;
durationMax = 20;

dir = 0;
spd = 0;
xChange = 0;
yChange = 0;

hitType = noone;
damage = 1;
knockback = 1;
radius = 20;

hitList = ds_list_create();

shimmer = part_type_create();
part_type_shape(shimmer, pt_shape_square);
part_type_size(shimmer, .04, .06, -.001, 0);
part_type_color_rgb(shimmer, 210, 255, 210, 255, 210, 255);
part_type_alpha1(shimmer, 1);