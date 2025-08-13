function script_createDataArrow(originX, originY, target, dataArray, dataNamesArray, duration) {
	var _arrow = instance_create_depth(originX, originY, -5000, obj_infoArrow);
	
	_arrow.target = target;
	_arrow.data = dataArray;
	_arrow.dataNames = dataNamesArray;
	
	_arrow.duration = duration;
	
	return _arrow;
}