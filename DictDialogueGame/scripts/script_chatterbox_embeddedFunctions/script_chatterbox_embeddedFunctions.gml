// all of these functions are intended to be sent to chatterscript to be used there, thus many of them are simplified so that you can use them without needing complex inputs
//all functions should be prefixed with "chatterbox_"

function script_chatterbox_distanceToThing(target) {
	if(instance_exists(target)) {
		return point_distance(x, y, target.x, target.y); // takes no arguments
	} else {
		return -1; // target not found
	}
}

/// @desc Returns a proper id from a string that is easy to type for chatterbox functions, returns the the gml id  ( can also return noone/-4 if the speaker does not exist)
/// @param {any*} target The string name of the thing you want to get the id for (OTHER or SELF) where self is the speaker and other is the thing you're speaking to. These are the ONLY valid inputs.
function script_chatterbox_getId(target) {
	if(target == "self") { // use defaults for me...
		return id;
	} else if(target == "other") { // ...and other, besides those you will have to get the id or something
		if(instance_exists(dialoguePartner)) {
			return dialoguePartner;
		} else {
			return noone;
		}
	}
}

function script_chatterbox_msg(p1, p2 = undefined, p3 = undefined, p4 = undefined, p5 = undefined) {
	show_debug_message("Chatterbox output: " + string(p1));
	if(!is_undefined(p2)) {
		show_debug_message("Chatterbox output: " + string(p2));
	}
	if(!is_undefined(p3)) { // output the other things if you get them, up to 5..
		show_debug_message("Chatterbox output: " + string(p3));
	}
	if(!is_undefined(p4)) {
		show_debug_message("Chatterbox output: " + string(p4));
	}
	if(!is_undefined(p5)) {
		show_debug_message("Chatterbox output: " + string(p5));
	}
}

function script_chatterbox_set(target, name, value) {
	variable_instance_set(target, name, value);
}

function script_chatterbox_setCollectionValue(name, value) {
	dialogueValueCollection[$ name] = value;
}