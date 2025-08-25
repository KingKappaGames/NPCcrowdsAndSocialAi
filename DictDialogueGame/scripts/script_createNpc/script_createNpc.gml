function script_createNpc(object, xx, yy) {
	var _npc = instance_create_depth(xx, yy, -yy, object);
	
	with(_npc) { // rescope to new npc
		with(obj_npc) {
			if(id != other.id) {
				createNpcRelationship(other.id); 
				other.createNpcRelationship(id); // with each new npc create opinion to and from all other existing ones
			}
		}	
	}
}