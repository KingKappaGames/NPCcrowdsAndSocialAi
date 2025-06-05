fsm.step();

x += xChange;
y += yChange;

if(xChange <= 0) {
	image_xscale = 1;
} else {
	image_xscale = -1;
}