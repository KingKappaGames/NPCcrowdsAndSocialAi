if(live_call()) { return live_result }

#macro emotionCount 7

enum E_emotions {
	happy = 0,
	sad = 1,
	anger = 2,
	fear = 3,
	humor = 4,
	tired = 5,
	neutral = 6
}

enum E_emotionImpacts {
	happy = 0,
	sad = 1,
	anger = 2,
	fear = 3,
	humor = 4,
	tired = 5,
	neutral = 6
}

emotionStates = array_create(emotionCount, 0);

emotionImpacts = array_create(emotionCount, 0);

emotionColors = [c_yellow, c_blue, c_red, #aa3399, c_orange, c_olive, c_grey];