if(live_call()) { return live_result }

audio_listener_orientation(0, 0, 1000, 0, -1, 0)

global.player = id;

ChatterboxVariableSet("player", id); // load player id into chatterbox globals.. kinda neat to do this kind of thing with chatterbox!

depth = -y;

heldItem = noone;

reaction = 0;

moveSpeed = .9;
xChange = 0;
yChange = 0;
speedDecay = .68;

sprinting = 0;
staminaMax = 300; 
stamina = staminaMax;

directId = noone;

leader = false;

followingLight = instance_create_depth(x, y, -1000, obj_pointLight);
followingLight.color = #ffffff;
followingLight.radius = 170;
followingLight.intensity = .09;
followingLight.castShadows = true;
followingLight.selfShadows = true;
followingLight.shaderType = LIGHT_SHADER_BRDF;

inDialogue = false;

var _prevLink = id;
repeat(1) {
	var _link = instance_create_depth(x, y, depth, obj_wormLink);
	_link.sourceId = _prevLink;
	_prevLink = _link;
}