//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float time;
uniform vec4 colorTint;
//const vec4 uvs = vec4(0., 0., 1., 1.); // for surfaces, no uvs! (1 for all)

const vec2 bubbleCenter = vec2(.5, .5); // because of the way the surface draws with the bubble centered the middle of the speech bubble should always be dead center aka .5, .5
uniform vec2 bubbleSize; // these values let you fade out the effect based on how central the pixel is
uniform float bubbleRadius; // this is just the normalized "dist" to the corner for reference against pixel distance
uniform float radiusBufferAdjust; // this a passed value along with the constant to shrink the bubble into nothing at the end

const float tintStrength = .9;
const float radialAdhesion = 15.0; // this basically is a way to set how "strict" the roundness of the bubble shader is, if it's really high, like 250, then the bubble will be a slightly pixelated oval, if it's low like 20 it will be a oil lamp like blob. Lower than that and it starts to fractal all over the screen soooo yeah..
const float radiusBuffer = 0.4; // this is the extra space added to the radius, probably other ways to handle this but eh

const vec4 baseColor = vec4(0., 0., 0., 1.0);

void main()
{                             //this sin nonsense here is just a pseudo random sampler (powered down to compress towards the bottom then flipped to compress towards the top)
	//float uvWidth = uvs.x - uvs.z;
	//float uvHeight = uvs.y - uvs.w;
	
	float verticalWiggleDistort =   (sin(time * 3.32 + v_vTexcoord.x * 173.2) * .003) - (sin(-time * 4.32 + v_vTexcoord.x * 233.2) * .0018);
	float horizontalWiggleDistort = (sin(time * 3.2 + v_vTexcoord.y * 174.8) * .003)   - (sin(-time * 4.32 + v_vTexcoord.y * 233.2) * .0018); // * uv range but.. for surfaces specifically not relevant
	vec2 newTexCoord = vec2(v_vTexcoord.x + horizontalWiggleDistort, v_vTexcoord.y + verticalWiggleDistort); 
	
	float alpha = 1.0;// - pow(fract(sin(time * 	.01 + v_vTexcoord.x * 1523. + v_vTexcoord.y * 4711.)* 125.0), 10.0);
	float dist = distance(vec2((bubbleCenter.x - v_vTexcoord.x), (bubbleCenter.y - v_vTexcoord.y) * (bubbleSize.x / bubbleSize.y)), vec2(0.0, 0.0)) / bubbleRadius; // uv dist from center to pixel (with a scale to make the lesser axis more represented, thus giving a compressed distance on one axis (basically it gives ovals), then you also normalize this to the bubble radius instead of the surface as a whole
	float cutoff = radialAdhesion - (dist - (radiusBuffer + radiusBufferAdjust)) * radialAdhesion; // over will draw
	
	float noiseValue = sin(v_vTexcoord.x * 103.2 + time * 3.52) + sin(v_vTexcoord.x * 159.84 - time * 1.87) + sin(v_vTexcoord.y * 113.2 + time * 2.71) + sin(v_vTexcoord.y * 224.34 - time * 1.56);
	
	if(noiseValue > cutoff * 1.) { // rising opacity here, from none to some to mostly full to normal draw
		discard; // clear pixel
	} else if(noiseValue > cutoff * .75) {
		gl_FragColor = vec4(mix(baseColor, colorTint, tintStrength));
		gl_FragColor.a = .2;
		//color the pixel with the tint color to give the edges of the cut regions a color, should look super cool, or at least be interesting
	} else if(noiseValue > cutoff * .67) {
		gl_FragColor = vec4(mix(baseColor, colorTint, tintStrength));
		gl_FragColor.a = .8;
		//color the pixel with the tint color to give the edges of the cut regions a color, should look super cool, or at least be interesting
	} else {
		gl_FragColor = baseColor; // add some kind of texturing here for the center black region, a warble or shine or something
	}
}

