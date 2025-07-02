/// @desc Creates essentially a water splash decal (as an object) that will do its standard animation stuff in a mask surface
/// @param {real} xx The x position to spawn at
/// @param {real} yy The y position to spawn at
/// @param {any*} sprite The sprite to use
/// @param {any*} image The image_index to start with
/// @param {real} [depthSet]=-yy The depth to force, only affects within the surface though
/// @param {real} [xscale]=1 horizontal scale
/// @param {real} [yscale]=1 vertical scale
/// @param {real} [blend]=1 Color to add to the base sprite
/// @param {real} [alpha]=1 Opacity.. duh
/// @param {real} [animationSpeed]=1 Multiplier of how fast to animate the sprite/images
function script_createWaterSplash(xx, yy, sprite, image, depthSet = -yy, xscale = 1, yscale = 1, blend = c_white, alpha = 1, animationSpeed = 1) {
	var _splash = instance_create_depth(xx, yy, depthSet, obj_waterSplash);
	_splash.sprite_index = sprite;
	_splash.image_index = image;
	_splash.image_xscale = xscale;
	_splash.image_yscale = yscale;
	_splash.image_blend = blend;
	_splash.image_alpha = alpha;
	_splash.image_speed = animationSpeed;
	//_splash.
}