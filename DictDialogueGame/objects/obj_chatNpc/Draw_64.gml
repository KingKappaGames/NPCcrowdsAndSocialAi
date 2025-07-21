if(instance_exists(bubble)) {
	var _right = view_wport[0];

	draw_set_alpha(.3);
	draw_rectangle_color(_right, 420, _right - 280, 80, c_grey, c_grey, c_dkgray, c_dkgray, false);
	draw_set_alpha(1);
		
	var _dict = dialogueValueCollection;
	
	
	draw_text(_right - 260, 100, "Speaker: " + string(id));
	draw_text(_right - 260, 140, "Current node: " + string(ChatterboxGetCurrent(chatterbox)));
	draw_text(_right - 260, 180, "Total lines: " + string(_dict.totalDialogueLinesGiven))
	draw_text(_right - 260, 220, "Times met: " + string(_dict.timesMet))
	draw_text(_right - 260, 260, "Have met once: " + string(_dict.firstMet))
	draw_text(_right - 260, 300, "Secret told: " + string(_dict.secretTold))
	draw_text(_right - 260, 340, "Options chosen: " + string(optionChosenArrayDebug))
	draw_text(_right - 260, 380, "Options viable: " + string(optionCriteriaArrayDebug))
	
	//draw_arrow(_right - 280, 420, lerp(_right - 280, speakerId.x - camera_get_view_x(view_current), .7), lerp(420, speakerId.y - camera_get_view_y(view_current), .7), 12);
	draw_arrow(_right - 280, 420, lerp(_right - 280, x - camera_get_view_x(view_camera[0]), .82), lerp(420, y - camera_get_view_y(view_camera[0]), .82), 12);
}