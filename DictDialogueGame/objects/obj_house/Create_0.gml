depth = -y;
image_xscale = 5;
image_yscale = 5;

shadow = new Crystal_Shadow(noone, CRYSTAL_SHADOW.STATIC);
shadow.x = x;
shadow.y = y - 30;
shadow.depth = depth + 1;
shadow.AddMesh(new Crystal_ShadowMesh().FromRect(104, 36, true));
shadow.shadowLength = 50;
shadow.Apply();