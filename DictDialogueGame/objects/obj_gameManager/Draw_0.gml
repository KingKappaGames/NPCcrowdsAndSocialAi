if(live_call()) { return live_result }

//var _bg = getBGSurf();

//draw_surface(_bg, 0, 0);

//surface_set_target(_bg);

draw_circle(mouse_x, mouse_y, 10, true);

draw_text(mouse_x, mouse_y, $"{mouse_x}/{mouse_y}");

draw_text(room_width - 50, 20, $"{mouse_x}/{mouse_y}");

//surface_reset_target();