draw_set_alpha(image_alpha);
draw_circle_color(x, y - height * .7, size, image_blend, #bbffff, false);
draw_set_alpha(.5);
draw_ellipse_color(x - size * 1.5, y - size, x + size * 1.5, y + size, c_ltgray, c_ltgray, false);
draw_set_alpha(1);