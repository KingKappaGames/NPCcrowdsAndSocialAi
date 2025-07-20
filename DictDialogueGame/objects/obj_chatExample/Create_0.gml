ChatterboxLoadFromFile("chat.yarn");
chatterbox = ChatterboxCreate("chat.yarn", true);

var _setVar = function(name, value, target = id) { // load this into chatterbox to set from there
	variable_instance_set(target, name, value);
}

var _setCollectionValue = function(name, value) {
	dialogueValueCollection[$ name] = value;
}

ChatterboxAddFunction("setVar", _setVar);
ChatterboxAddFunction("setCollectionValue", _setCollectionValue);

ChatterboxJump(chatterbox, "Start");

dialogueValueCollection = {
	firstMet : 0,
	secretTold : 0,
	questDone : 0,
	itemGiven : 0,
	timesMet : 0,
	totalDialogueLinesGiven : 0 // total amount of talking to this person, can be thought of as familiarity
}

optionChosenArrayDebug = -1;
optionCriteriaArrayDebug = -1;

text = -1;
metadata = -1;

bubble = noone;

ChatterboxAddFunction("pDistance", distance_to_object);
ChatterboxAddFunction("showMsg", script_junkScript);
ChatterboxVariableDefault("player", 0);
ChatterboxVariableSet("player", obj_player);


//var _text = ChatterboxGetAllContentString(chatterbox);
//var _meta = ChatterboxGetContent(chatterbox, 0);
//var _meta2 = ChatterboxGetContent(chatterbox, 1);
//var _meta3 = ChatterboxGetContent(chatterbox, 2);
//var _meta4 = ChatterboxGetContentCount(chatterbox);

//var _abc = 0;