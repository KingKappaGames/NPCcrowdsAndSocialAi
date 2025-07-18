ChatterboxLoadFromFile("chat.yarn");
chatterbox = ChatterboxCreate("chat.yarn", true);
ChatterboxJump(chatterbox, "Start");

dialogueGlobalPosition = 0;
dialoguePosition = 0;

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