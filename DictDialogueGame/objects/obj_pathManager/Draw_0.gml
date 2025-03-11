var _pos = script_getClosestPathPosition(pathQuestion, mouse_x, mouse_y, 30, -1, -1)

pathClosestX = path_get_x(pathQuestion, _pos);
pathClosestY = path_get_y(pathQuestion, _pos);

draw_text(mouse_x, mouse_y + 15, _pos);

draw_circle(pathClosestX, pathClosestY, 5 + irandom(2), true);