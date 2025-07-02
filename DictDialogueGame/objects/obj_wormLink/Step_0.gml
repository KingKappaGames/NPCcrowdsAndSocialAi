var _sourceX = sourceId.x;
var _sourceY = sourceId.y;
var _dist = point_distance(x, y, _sourceX, _sourceY);

if(_dist > linkLength) {
	var _dir = point_direction(x, y, _sourceX, _sourceY);
	x = _sourceX - dcos(_dir) * linkLength;
	y = _sourceY + dsin(_dir) * linkLength;
	
	image_angle = _dir;
}

material.x = x;
material.y = y;
material.angle = image_angle;