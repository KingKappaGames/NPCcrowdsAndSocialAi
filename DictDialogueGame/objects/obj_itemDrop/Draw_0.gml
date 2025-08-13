draw_circle(x, y, 3 + irandom(2), false);

if(keyboard_check(vk_control)) {
	var _data = [
	item.itemType,
	item.value,
	item.alignment,
	item.complexity,
	item.danger,
	item.magical, 
	item.weight,
	item.owner,
	];
	
	var _dataNames = [
	"type",
	"value",
	"alignment",
	"complexity",
	"danger",
	"magical",
	"weight",
	"owner"
	];
	
	for(var _i = array_length(_data) - 1; _i >= 0; _i--) {
		draw_set_halign(fa_right);
		draw_text_transformed(x + 60, y - 200 + _i * 12, _data[_i], .8, .8, 0);
		draw_set_halign(fa_left);
		draw_text_transformed(x + 70, y - 200 + _i * 12, _dataNames[_i], .8, .8, 0);
	}
}