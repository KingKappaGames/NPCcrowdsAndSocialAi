///@desc Either searches a name from an array of name fragments (passed in first param) or puts together a name with pieces given up to three, spaces will be auto inserted between all pieces
function script_npcFindName(nameFirstSearch, nameMiddleSearch = undefined, nameLastSearch = undefined){
	var _fullName = "";
	if(is_array(nameFirstSearch)) {
		var _pieces = array_length(nameFirstSearch);
		for(var _i = 0; _i < _pieces - 1; _i++) {
			_fullName += nameFirstSearch[_i];
			_fullName += " ";
		}
		_fullName += nameFirstSearch[_pieces - 1]; // erm its a fence post loop... nerd emoji
	} else {
		_fullName = nameFirstSearch;
		if(!is_undefined(nameMiddleSearch)) {
			_fullName += " ";
			_fullName += nameMiddleSearch;
		}
		
		if(!is_undefined(nameLastSearch)) {
			_fullName += " ";
			_fullName += nameLastSearch;
		}
	}
	
	with(obj_npc) {
		if(string_lower(name) == _fullName) {
			return id; // this needs to be more complex, it needs to sort out pseudonyms and non 2 part names (titles with "the" for example..) and whatnot so you can do the first 2 or 3 names they might have, instead of the proper full name every time.. LATER, todo or whatever
		}
	}
	
	return noone;
}