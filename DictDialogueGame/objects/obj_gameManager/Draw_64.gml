draw_text(20, 20, global.weather);
draw_text(20, 40, global.time);
draw_text(20, 60, global.territory);

draw_text(view_wport[0] - 65, 20, fps_real);

draw_text(view_wport[0] - 65, 40, mouse_x);

draw_text(view_wport[0] - 65, 60, mouse_y);

draw_text(view_wport[0] - 65, 80, instance_number(obj_npc));

draw_text(50, 300, instance_number(obj_infoArrow));