if(live_call()) { return live_result }

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
followingLight.radius = 240;
followingLight.intensity = .3;
followingLight.castShadows = true;
followingLight.selfShadows = true;