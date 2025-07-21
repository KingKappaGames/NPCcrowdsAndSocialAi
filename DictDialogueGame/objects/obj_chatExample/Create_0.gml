global.chatManager = id;

ChatterboxLoadFromFile("chat.yarn");
ChatterboxLoadFromFile("chatFarlands.yarn"); // load all files here..

ChatterboxAddFunction("getId", script_chatterbox_getId);
ChatterboxAddFunction("setVar", script_chatterbox_set);
ChatterboxAddFunction("setCollectionValue", script_chatterbox_setCollectionValue);
ChatterboxAddFunction("distanceTo", script_chatterbox_distanceToThing);
ChatterboxAddFunction("showMsg", script_chatterbox_msg);

ChatterboxVariableDefault("player", -4); // set in player