randomize();

global.gameManager = id;

#region crystal lights nonsense

gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
gpu_set_alphatestenable(true);

// create system responsible for rendering lights, shadows, materials, etc.
crystalRenderer = new Crystal_Renderer();
crystalRenderer.SetHDREnable(true);
crystalRenderer.SetMaterialsEnable(true);
crystalRenderer.SetAmbientColor(#0b001a);
crystalRenderer.SetAmbientIntensity(.2);

#endregion

#region ppx nonsense

application_surface_draw_enable(false);

ppxRenderer = new PPFX_Renderer();

ppxRenderer.SetHDREnable(true);

var effects = [
   // new FX_Colorize(true, color_get_hue(#200237), 255, 255, .33),
	new FX_NoiseGrain(true, .03, .5, .5, 1),
	new FX_Bloom(true, 5, 2, 10, 1.3, #ffffff),
	new FX_Saturation(true, 1),
	//new FX_Vignette(true, 1, 1, .3, 1.15, c_red, [.5, .5], .2, false) 
	
];

ppxDefaultProfile = new PPFX_Profile("Default", effects);

ppxRenderer.ProfileLoad(ppxDefaultProfile);

#endregion

#region particles

global.sys = part_system_create();
part_system_depth(global.sys, -5000);

global.waterTrail = part_type_create();
var _wTrail = global.waterTrail;
part_type_sprite(_wTrail, spr_waterTrail, 1, 0, 1);
part_type_alpha2(_wTrail, 1, 0);
part_type_gravity(_wTrail, .06, 270);
part_type_speed(_wTrail, 0, .5, 0, 0);
part_type_direction(_wTrail, 0, 360, 0, 0);
part_type_life(_wTrail, 30, 60);
part_type_size(_wTrail, .8, 1.5, 0, 0);
part_type_color2(_wTrail, #ffffff, #bbbbbb);

global.waterSplash = part_type_create();
var _wSplash = global.waterSplash;
part_type_sprite(_wTrail, spr_waterTrail, 1, 0, 1);
part_type_alpha2(_wSplash, .4, 0);
part_type_gravity(_wSplash, .06, 270);
part_type_speed(_wSplash, 0, .5, 0, 0);
part_type_direction(_wSplash, 45, 135, 0, 0);
part_type_life(_wSplash, 25, 75);
part_type_size(_wSplash, .8, 1.5, 0, 0);
part_type_color2(_wSplash, #ffffff, #bbbbbb);
//part_type_blend(_wSplash, true);

#endregion

scribble_anim_wave(1.8, .25, .1);
scribble_font_set_default("font_dialogueText");


#region allegiances
enum ALLEGIANCES {
	empire, 
	fatalists, //1
	neutral, 
	proudApostle, //3
	reachesApostle, 
	mortalist // 5
}

#macro allegianceCount 6
global.allegianceCrossReference = ds_grid_create(allegianceCount, allegianceCount); // each faction x each faction, gives the result of each combination
for(var _gridX = 0; _gridX < allegianceCount; _gridX++) {
	for(var _gridY = 0; _gridY < allegianceCount; _gridY++) {
		ds_grid_set(global.allegianceCrossReference, _gridX, _gridY, random(1)); // 0 being hates, 1 being loves (the x gives the see'er, y gives the seen)
	} // right now this is just randomly generated so whatever but eventually this will store the relations of all the groups and this can be altered to change the perceptions of all things in the game dynamically
}
#endregion

global.weather = choose("sunny", "overcast", "rain", "wind", "storm", "snow", "mild", "hot", "cold", "drought");
global.time = choose("day", "night", "morning", "dusk", "noon", "middle of the night");
global.territory = choose("pride lands", "dark realm", "quiet vegas", "surface", "reaches");

global.dayTime = 250;

backgroundSurf = -1;

getBGSurf = function() {
	if(!surface_exists(backgroundSurf)) {
		backgroundSurf = surface_create(1000, 1000)	;
	}
	
	return backgroundSurf;
}


animcurve_set_live(curve_SBgrow, true);
animcurve_set_live(curve_SBemerge, true);
sprite_set_live(spr_background, true);
shader_set_live(shd_speechBubbleFog, 1);