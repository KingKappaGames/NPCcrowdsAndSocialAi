var _item = heldItem;

if(instance_exists(_item)) {
	if(point_distance(x, y, _item.x, _item.y) < 120) {
		script_ACT_steal(id, _item.x, _item.y, _item);
	}
}