depth = 2500;

surf = -1;


getSurf = function() {
	if(!surface_exists(surf)) {
		surf = surface_create(2400, 2400);
	}
	
	return surf;
}

clickTimer = 0;