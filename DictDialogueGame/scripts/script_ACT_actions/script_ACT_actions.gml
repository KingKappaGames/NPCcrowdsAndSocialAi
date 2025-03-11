//script_ACT_ must come before each of these scripts to cluster them in the group
//of scripts that generates a social response.. Perhaps there are better ways
//to create perception of actions that to tie them all to related scripts?


//where I write that a script "implies" values that means that those values might not actually exist but they should at some point for the script to use as data for it's decisions


///@desc This script gives out the reactions to "stealing" to the given witnesses based on the item given
function script_ACT_steal(xx, yy, comitter, owner, item, subjects = -1){ // implies item weight/value/ownership and npc allegiances
	if(instance_exists(owner)) { // if the item is owned at all
		if(subjects == -1) {
			var _radius = 120 + item.weight * 10; // item size or weight or whatever increases this?  (this must bring in npc values, if they're looking away, blind, too far, asleep, ect, they won't notice and those values have to be checked in here.)
			collision_circle_list(xx, yy, _radius, obj_npc, false, true, subjects, false);
		}
	
		var _ownerAllegiance = owner.objectAllegiance; // proxy for item allegiance
		var _comitterAllegiance = comitter.objectAllegiance;
		var _overtness = clamp((item.value / 100) * (1 / item.weight), 0, 1);
		var _blame = 1; // this represents how petty the crime was, stealing food, convinience or such would lead to diminished responses vs stealing daggers, poisons, and jewelry perhaps would lead to harsher punishment and animosity even if the item wasn't worth as much.
		if(item.type == "weapon" || item.danger > .5) {
			_blame *= 3;
		} else if(item.danger < .1 || item.type == "food") {
			_blame *= .4;
		}
	
		var _resultEmotions = [0, 0, 0, 0]; // anger, fear, suspicion, happiness
		var _subjectCount = ds_list_size(subjects);
		for(var _subjectI = 0; _subjectI < _subjectCount; _subjectI++) {
			_resultEmotions = [0, 0, 0, 0];
			if(_ownerAllegiance == subjects[_subjectI].objectAllegiance) {
				_resultEmotions[0] += .3; // owners are more angry and less suspicious about stolen items that belong to them
				_resultEmotions[2] *= .25;
			}
			
			//script_influenceNpc(_resultEmotions[0], _resultEmotions[1], _resultEmotions[2], _resultEmotions[3]);
			return _resultEmotions;
		}
	}
}

function script_ACT_pray(){
	
}

function script_ACT_kill(){
	
}

function script_ACT_sneak(){
	
}