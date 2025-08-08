if(mouse_check_button(mb_right)) {
	if(clickTimer == 0) {
		script_createWaterProjectile(mouse_x, mouse_y, 1,, random_range(-2, 2), random_range(-2, 2), random_range(.2, 7));
	} else {
		if(clickTimer > 30) {
			script_createWaterProjectile(mouse_x, mouse_y, 1,, random_range(-2, 2), random_range(-2, 2), random_range(.2, 7));
		}
	}
	clickTimer++;
} else {
	clickTimer = 0;
}


//if(irandom(1) == 0) {
	//script_createWaterProjectile(x + irandom(2400), y + irandom(2400), 500, random_range(1.5, 2.2), random_range(-1, 1), random_range(-1, 1), random_range(-5, -6),,,, false);
//}


if(keyboard_check_released(vk_f5)) {
	script_createWaterProjectile(mouse_x, mouse_y, 500, 21, random_range(-1, 1), random_range(-1, 1), 0);
}