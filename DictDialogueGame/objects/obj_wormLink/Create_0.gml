sourceId = noone;

linkLength = 30;

material = new Crystal_Material(id);
material.normalSprite = spr_wormLinkNormal;
material.normalSpriteSubimg = 1;
material.emissiveSprite = spr_wormLinkEmissive;
material.emissiveSpriteSubimg = 1;
material.emissionIntensity = 1;
material.emission = 3.5;

material.x = x;
material.y = y;
material.angle = image_angle;

//material.metallicSprite = sprite_index;
//material.metallicSpriteSubimg = 7;
//material.roughnessSprite = sprite_index;
//material.roughnessSpriteSubimg = 6;
//material.aoSprite = sprite_index;
//material.aoSpriteSubimg = 5;
material.Apply();