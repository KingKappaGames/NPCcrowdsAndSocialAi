depth = -y + 16;
image_xscale = 4;
image_yscale = 4;

shadow = new Crystal_Shadow(noone, CRYSTAL_SHADOW.STATIC);
shadow.x = x;
shadow.y = y - 10;
shadow.depth = depth + 17;
shadow.AddMesh(new Crystal_ShadowMesh().FromRect(80, 60, true));
shadow.shadowLength = 50;
shadow.Apply();


light = instance_create_depth(x, y - 150, 0, obj_pointLight);
light.color = #ffff88;
light.radius = 360;
light.intensity = .32;
light.castShadows = true;
light.selfShadows = true;
light.depth = depth - 1;

material = new Crystal_Material(id);
material.emissiveSprite = spr_pixelTowerEmmisive;
material.emissiveSpriteSubimg = 0;
material.emission = 2;
material.emissionColor = c_red;
material.Apply();