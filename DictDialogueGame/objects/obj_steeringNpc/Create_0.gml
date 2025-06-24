if(live_call()) { return live_result }
	
#macro seekDirections 16
#macro seekDirectionIncrement 22.5

goalArray = array_create(seekDirections);

consideredInfluences = ds_list_create();

moveSpeed = 1.5;
moveDir = 0;
xChange = 0;
yChange = 0;

timer = 0;