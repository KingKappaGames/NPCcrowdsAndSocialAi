var _surf = getSurf();

surface_set_target(_surf);

draw_clear_alpha(#61cfed, 1);

var _x = x;
var _y = y;
with(obj_waterSplash) {
	x -= _x;
	y -= _y;
	draw_self();
	x += _x;
	y += _y;
}

gpu_set_blendmode(bm_subtract);

draw_sprite(spr_waterMask, 0, 0, 0); // cut mask shape out of water and ripples

gpu_set_blendmode(bm_normal);

surface_reset_target();

draw_surface(surf, x, y);
