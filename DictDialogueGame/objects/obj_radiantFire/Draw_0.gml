event_inherited();

var _size = 20;
draw_triangle(x + dcos(drawAngle) * _size, y - dsin(drawAngle) * _size, x + dcos(drawAngle + 120) * _size, y - dsin(drawAngle + 120) * _size, x + dcos(drawAngle + 240) * _size, y - dsin(drawAngle + 240) * _size, true);
draw_triangle(x + dcos(drawAngle + 60) * _size, y - dsin(drawAngle + 60) * _size, x + dcos(drawAngle + 180) * _size, y - dsin(drawAngle + 180) * _size, x + dcos(drawAngle + 300) * _size, y - dsin(drawAngle + 300) * _size, true);