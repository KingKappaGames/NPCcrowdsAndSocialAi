//if(live_call()) { return live_result }

event_inherited();

draw_set_color(image_blend);

draw_circle(x, y, 10, false);

for(var _i = 0; _i < 120; _i++) {
	//textId.draw(x, y + _i * 3, typer);
	//text.draw(x, y + _i * 3);
	//textJr.Draw(x, y + _i * 3);
	//draw_text(x, y + _i * 3, "[slant]This[/slant] [shake]weapon[/shake] costs [rainbow]a whole kingdom[/rainbow]. [/][wave]What a rip off!")
}

//if(keyboard_check(vk_alt)) {
	//typer.in(.2, .5);
	//typer.reset()
	//scribble_anim_wave(18, .3, .05);
	//scribble_anim_shake(5, 1);
	//scribble_anim_rainbow(1, .001);
//}
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