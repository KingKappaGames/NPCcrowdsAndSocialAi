///@desc Gets the opinion of the passed npc from the calling npc (assumed local scope)
function script_npcGetOpinionData(npc) { // these scripts are from the perspective of an npc to another
	var _opinions = npc.npcRelationshipCollection;
	
	var _opinionCount = array_length(_opinions);
	
	for(var _i = 0; _i < _opinionCount; _i++) {
		if(_opinions[_i].npc == id) {
			return _opinions[_i];
		}
	}
	
	return noone;
}