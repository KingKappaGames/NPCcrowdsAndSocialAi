if(live_call()) { return live_result }

draw_circle(x, y, 10, false);

/*
draw_circle(x, y, 15, true);
for(var _i = 0; _i < seekDirections; _i++) {
	var _desire = goalArray[_i] * 50;
	draw_line(x, y, x + dcos(_i * seekDirectionIncrement) * (15 + _desire), y - dsin(_i * seekDirectionIncrement) * (15 + _desire));
}


for(var _dir = 0; _dir < 360; _dir += seekDirectionIncrement) {
	draw_text(x + dcos(_dir) * 35, y - dsin(_dir) * 35 + 120, string(goalArray[_dir / seekDirectionIncrement]));
}