if(live_call()) { return live_result }

depth = -y;

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


mouseLight = instance_create_depth(x, y, -1000, obj_pointLight);
mouseLight.color = #ffffff;
mouseLight.radius = 750;
mouseLight.intensity = .4;
mouseLight.shaderType = LIGHT_SHADER_BRDF;



var _prevLink = id;
repeat(20) {
	var _link = instance_create_depth(x, y, depth, obj_wormLink);
	_link.sourceId = _prevLink;
	_prevLink = _link;
}