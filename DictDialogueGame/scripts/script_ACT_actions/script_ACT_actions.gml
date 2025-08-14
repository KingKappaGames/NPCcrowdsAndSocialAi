//script_ACT_ must come before each of these scripts to cluster them in the group
//of scripts that generates a social response.. Perhaps there are better ways
//to create perception of actions that to tie them all to related scripts?


//where I write that a script "implies" values that means that those values might not actually exist but they should at some point for the script to use as data for it's decisions


///@desc This script gives out the reactions to "stealing" to the given witnesses based on the item given
function script_ACT_steal(comitter, xx, yy, item, subjects = -1){ // implies item weight/value/ownership and npc allegiances
	if(!instance_exists(item)) {
		return -1;
	}
	
	item = item.item;
	var _owner = item.owner;
	var _createdList = false;
	
	if(instance_exists(_owner)) { // if the item is owned at all	
		if(subjects == -1) {
			var _radius = /*big for testing*/420 + item.weight * 10; // item size or weight or whatever increases this?  (this must bring in npc values, if they're looking away, blind, too far, asleep, ect, they won't notice and those values have to be checked in here.)
			subjects = ds_list_create();
			_createdList = true;
			collision_circle_list(xx, yy, _radius, obj_npc, false, true, subjects, false);
		}
	
		var _ownerAllegiance = _owner.objectAllegiance; // proxy for item allegiance
		var _comitterAllegiance = comitter.objectAllegiance;
		var _overtness = clamp((item.value / 100) * (1 / item.weight), 0, 1);
		var _blame = 1; // this represents how petty the crime was, stealing food, convinience or such would lead to diminished responses vs stealing daggers, poisons, and jewelry perhaps would lead to harsher punishment and animosity even if the item wasn't worth as much.
		if(item.itemType == "weapon") {
			_blame *= 2.4;
		} else if(item.itemType == "food") {
			_blame *= .3;
		}
		
		 if(item.danger > .5) {
			 _blame *= sqr(.5 + item.danger); // uh oh!
		 }
	
		var _resultEmotions = 0; // opinion, mood, trust, anger, fear, energy
		var _subjectCount = ds_list_size(subjects);
		for(var _subjectI = 0; _subjectI < _subjectCount; _subjectI++) {
			var _npc = subjects[| _subjectI];
			_resultEmotions = [_blame * .2, _blame * .04, _blame * .2, _blame * .1, _blame * .02, 0]; //TODO horrible, remake this with real values
			
			for (var _i = 0; _i < 6; _i++) {
			    _resultEmotions[_i] *= .1;
			}
			
			if(_owner.objectAllegiance == _npc.objectAllegiance) { // clan linking i guess? THough this should be more complex
				var _itemValueToOwner = script_npcJudgeItem(_npc, item);
				
				for(var _i = array_length(_resultEmotions) - 1; _i >= 0; _i--) {
					_resultEmotions[_i] *= _itemValueToOwner; // more or less value means more or less response, though, that's not a 1:1 in any way, more value might lead to less anger and more fear or something idk (think about someone stealing your pencil vs watch vs car, very different emotions in there)
				}
				
				_resultEmotions[0] *= 3;
				_resultEmotions[2] *= 2;
				_resultEmotions[3] *= 2; // owners are more angry and less suspicious about stolen items that belong to them
				_resultEmotions[4] *= .7; // idk something something the owner should handle things and know about their stuff, thus not be scared..? Again this needs to be much more complex
			}
			
			
	
			var _dataNames = [
			"emotionOpinion",
			"emotionMood",
			"emotionTrust",
			"emotionAnger",
			"emotionFear",
			"emotionEnergy",
			];
			
			script_createDataArrow(_npc.x, _npc.y, comitter, _resultEmotions, _dataNames, 300);
			
			script_dialogueInfluenceNpc(_npc, comitter, _resultEmotions[0], _resultEmotions[1], _resultEmotions[2], _resultEmotions[3], _resultEmotions[4], _resultEmotions[5]);
		}
	}
	
	if(_createdList) {
		ds_list_destroy(subjects);
	}
}

function script_ACT_pray(){
	
}

function script_ACT_kill(){
	
}

function script_ACT_sneak(){
	
}