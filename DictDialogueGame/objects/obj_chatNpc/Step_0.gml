if(instance_exists(speakerId)) {
	if(point_distance(speakerId.x, speakerId.y, x, y) > 100) { // close if speaker too far away
		dialogueShutdownChat();
	}
} else {
	if(text != -1) {
		dialogueShutdownChat();
	}
}

var _target = global.player; // well now that I've added this little layer this needs cleaned up but it works nicely, I think?
if(keyboard_check_released(vk_space) || mouse_check_button_released(mb_left) || (emotionReactionsAvaialble && (keyboard_check_released(ord("7")) || keyboard_check_released(ord("8")) || keyboard_check_released(ord("9"))))) {
	if(point_distance(x, y, _target.x, _target.y) < interactionRange) { // only player can really start a dialogue this way..
		dialogueDoInteraction(_target);
	}
}