if(live_call()) return live_result

if(instance_exists(speakerId)) {
	var _camWidth = camera_get_view_width(view_camera[0]);
	var _camHeight = camera_get_view_height(view_camera[0]);
	
	draw_rectangle(120, _camHeight, _camWidth - 120, _camHeight - 40, false); // responses and entry
	draw_rectangle(120, _camHeight - 60, _camWidth - 120, _camHeight - 100, false);
	if(dialogueString != "") {
		if(dialogueValid) {
			draw_rectangle_color(130, _camHeight - 100, _camWidth - 130, _camHeight - 60, c_green, c_lime, c_yellow, c_lime, true);
			draw_set_color(c_black);
			draw_text(130, _camHeight - 90, dialogueString);
			draw_set_color(c_white);
		} else {
			draw_rectangle_color(130, _camHeight - 100, _camWidth - 130, _camHeight - 60, c_red, c_orange, c_red, c_maroon, true);
			draw_set_color(c_black);
			draw_text(130, _camHeight - 90, dialogueString);
			draw_set_color(c_white);
		}
	}

	if(responseString != "") {
		draw_set_color(c_black);
		draw_text(130, _camHeight - 30, responseString);
		draw_set_color(c_white);
	}
}