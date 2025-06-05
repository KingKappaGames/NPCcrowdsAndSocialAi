randomize();

global.gameManager = id;

global.sys = part_system_create();
part_system_depth(global.sys, -5000);

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

backgroundSurf = -1;

getBGSurf = function() {
	if(!surface_exists(backgroundSurf)) {
		backgroundSurf = surface_create(1000, 1000)	;
	}
	
	return backgroundSurf;
}

sprite_set_live(spr_background, true);