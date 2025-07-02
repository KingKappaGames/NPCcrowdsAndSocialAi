depth = -y + 12;
image_xscale = 5;
image_yscale = 5;

shadow = new Crystal_Shadow(noone, CRYSTAL_SHADOW.STATIC);
shadow.x = x;
shadow.y = y - 30;
shadow.depth = depth + 13;
shadow.AddMesh(new Crystal_ShadowMesh().FromRect(104, 36, true));
shadow.shadowLength = 50;
shadow.Apply();

material = new Crystal_Material(id);
material.normalSprite = spr_towerNormal;
material.normalSpriteSubimg = 0;
//material.emissiveSprite = sprite_index;
//material.emissiveSpriteSubimg = 2;
//material.emissionIntensity = 2;
//material.metallicSprite = sprite_index;
//material.metallicSpriteSubimg = 7;
//material.roughnessSprite = sprite_index;
//material.roughnessSpriteSubimg = 6;
//material.aoSprite = sprite_index;
//material.aoSpriteSubimg = 5;

material.Apply();