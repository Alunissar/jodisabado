shader_type spatial;
render_mode unshaded, depth_prepass_alpha, cull_disabled, blend_mix;
uniform vec4 mainCol : source_color;
uniform sampler2D mainTex : source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 col = texture(mainTex, UV) * mainCol;
	ALBEDO = col.rgb;
	ALPHA = col.a;
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
