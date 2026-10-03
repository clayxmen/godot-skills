// res://assets/shaders/dissolve_burn.gdshader
shader_type canvas_item;
render_mode blend_mix;

uniform sampler2D noise_texture : repeat_enable, filter_linear;
uniform float dissolve_amount : hint_range(0.0, 1.0, 0.01) = 0.0;
uniform float burn_size : hint_range(0.0, 0.2, 0.01) = 0.05;
uniform vec4 burn_color : source_color = vec4(1.0, 0.4, 0.0, 1.0);
uniform float emission_intensity : hint_range(1.0, 10.0, 0.1) = 3.0;

void fragment() {
	vec4 main_tex = texture(TEXTURE, UV);
	float noise_val = texture(noise_texture, UV).r;

	if (noise_val < dissolve_amount) {
		discard;
	}

	float edge_dist = noise_val - dissolve_amount;
	if (edge_dist < burn_size && dissolve_amount > 0.0) {
		float factor = 1.0 - (edge_dist / burn_size);
		vec3 glow = burn_color.rgb * emission_intensity;
		COLOR = vec4(mix(main_tex.rgb, glow, factor), main_tex.a);
	} else {
		COLOR = main_tex;
	}
}
