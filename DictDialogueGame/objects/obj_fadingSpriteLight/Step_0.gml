timer--;

var _sizeOut = animcurve_channel_evaluate(sizeCurve, 1 - (timer / timerMax));

radius = sizeOriginalX * _sizeOut;
intensity = _sizeOut;

if(timer <= 0) {
	instance_destroy();
}