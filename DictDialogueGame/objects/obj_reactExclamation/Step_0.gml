duration--;
var _age = 1 - (duration / durationMax);
var _scale = animcurve_channel_evaluate(channel, _age);

image_xscale = baseScale * _scale;
image_yscale = baseScale * _scale;

image_angle += spinSpeed;

hspeed *= speedDecay;
vspeed *= speedDecay;
spinSpeed *= spinDecay;

if(_age >= 1) {
	instance_destroy();
}