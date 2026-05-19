shader_type canvas_item;

uniform vec4 baseCol;
uniform vec4 lineCol;
uniform float warp;
global uniform sampler2D Perlin1;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	// centraliza UV
	vec2 gridUV = UV;
	gridUV= abs(gridUV - 0.5);
	
	// anim com noise
	float noise = (texture(Perlin1, gridUV).x + 1.0)/2.0;
	float anim = sin(TIME+(noise*20.0))+.5;
	
	// raio do centro
	float rad = pow(gridUV.x,2) + pow(gridUV.y,2);
	// warping
	gridUV= gridUV + warp * rad;
	// quadradização
	gridUV.x = fract(gridUV.x*50.0);
	gridUV.y = fract(gridUV.y*50.0* (SCREEN_PIXEL_SIZE.x/SCREEN_PIXEL_SIZE.y));
	// faz linha
	gridUV = abs(gridUV-.5)+.5;
	// apaga o meio
	gridUV-= (.8-rad)*1.3;
	// saturate
	gridUV = clamp(gridUV,0,1);
	
	COLOR = mix(baseCol,lineCol, gridUV.x * gridUV.y * anim);
	//COLOR = vec4(gridUV,0,1);
	
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
