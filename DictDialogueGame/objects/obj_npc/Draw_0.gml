if(live_call()) { return live_result }

draw_set_color(image_blend);

draw_circle(x, y, 10, false);

for(var _i = 0; _i < 1; _i++) {
	textId.draw(x, y + _i * 3, typer);
}
msg(typer.get_state())

if(keyboard_check(vk_alt)) {
	typer.in(.2, .5);
	typer.reset()
	scribble_anim_wave(18, .3, .05);
	scribble_anim_shake(5, 1);
	scribble_anim_rainbow(1, .001);
}
//draw_text(x, y + _i * 5, "This weapon costs BIG CROWN BIG CROWN 1,200");

//draw_circle(x, y, playerCommentRange, true);

//draw_circle(x, y, 100, true);

if(pathMoving) {
	//draw_circle(x, y, 30 + irandom(10), true);
	//draw_path(pathCurrent, 0, 0, true);
	//draw_text(x, y + 20, $"path position: {path_position}");
	//draw_text(x, y + 32, path_get_name(pathCurrent));
	//draw_text(x, y + 44, $"pathCurrentLength: {pathCurrentLength}");
	
	//raw_text(x, y - 60, pathCurrentStartTime);
	
	//draw_circle(pathGoalX, pathGoalY, pathGoalRadius, true);
}

draw_set_color(c_white);

if(leader) {
	draw_sprite(spr_crown, 0, x, y - 10);
} else if(instance_exists(followingId)) {
	draw_sprite(spr_crown, 1, x, y - 10);
}

if(keyboard_check(vk_control)) {
	var _data = [
	residence,
	homeland,
	gender,
	age,
	objectAllegiance,
	
	occupation,
	religion,
	wealth,
	status,
	alignment,                              /// monka bro wtf
	criminality,
	magicStrength,
	magicField,
	powerLevel,
	
	extraversion,
	selfWorth,
	personality,
	trust,
	energyPersonality,
	joy,
	curiosity,
	combativeness,
	knowledgeGeneral, 
	
	speedValue,
	weightValue,
	keenness
	];
	
	var _dataNames = [
	"residence",
	"homeland",
	"gender",
	"age",
	"objectAllegiance",
	
	"occupation",
	"religion", /// monka bro wtf
	"wealth",
	"status",
	"alignment",
	"criminality",
	"magicStrength",
	"magicField",
	"powerLevel",
	
	"extraversion",
	"selfWorth",
	"personality",
	"trust",
	"energyPersonality",
	"joy",
	"curiosity",
	"combativeness",
	"knowledgeGeneral",
	
	"speedValue",
	"weightValue",
	"keenness"
	];
	
	for(var _i = array_length(_data) - 1; _i >= 0; _i--) {
		draw_set_halign(fa_right);
		draw_text_transformed(x + 60, y - 200 + _i * 12, _data[_i], .8, .8, 0);
		draw_set_halign(fa_left);
		draw_text_transformed(x + 70, y - 200 + _i * 12, _dataNames[_i], .8, .8, 0);
	}
}