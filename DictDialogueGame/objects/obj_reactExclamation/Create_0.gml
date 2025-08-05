type = "exclamation";

duration = 55;
durationMax = 55;

baseScale = 1;
image_angle = irandom_range(-1, 1);

xChange = random_range(-1, 1);
yChange = random_range(-1, 1);
spinSpeed = random_range(-3.4, 3.4);

speedDecay = .92;
spinDecay = .82;

curve = curve_exclamationPop;
channel = animcurve_get_channel(curve_exclamationPop, "scale");

if(type == "exclamation") {
	audio_play_sound(snd_reactExclamationMark, 0, 0);
} else if(type == "question") {
	audio_play_sound(snd_reactQuestionMark, 0, 0);
} else if(type == "no") {
	
}