duration = 150;
durationMax = 150;

xChange = 0;
yChange = 0;

speedDecay = .98;

light = instance_create_depth(x, y, depth - 1, obj_pointLight);
light.color = #ffff00;
light.radius = 150;
light.intensity = 1;
light.shaderType = LIGHT_SHADER_BRDF;