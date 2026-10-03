// res://assets/shaders/stylized_water.gdshader
shader_type spatial;
render_mode blend_mix, depth_draw_always, cull_back;

uniform vec4 shallow_color : source_color = vec4(0.2, 0.7, 0.9, 0.8);
uniform vec4 deep_color : source_color = vec4(0.05, 0.2, 0.5, 0.95);
uniform float depth_distance : hint_range(0.1, 20.0, 0.1) = 3.0;

uniform float wave_speed : hint_range(0.1, 5.0, 0.1) = 1.0;
uniform float wave_amplitude : hint_range(0.0, 2.0, 0.05) = 0.2;
uniform float wave_frequency : hint_range(0.1, 5.0, 0.1) = 0.8;

uniform sampler2D depth_texture : hint_depth_texture, filter_linear_mipmap;
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

void vertex() {
	float wave1 = sin(VERTEX.x * wave_frequency + TIME * wave_speed);
	float wave2 = cos(VERTEX.z * wave_frequency * 1.5 + TIME * wave_speed * 1.2);
	VERTEX.y += (wave1 + wave2) * wave_amplitude;
}

void fragment() {
	float depth_raw = texture(depth_texture, SCREEN_UV).r;
	vec3 ndc = vec3(SCREEN_UV * 2.0 - 1.0, depth_raw);
	vec4 world = INV_PROJECTION_MATRIX * vec4(ndc, 1.0);
	vec3 world_pos = world.xyz / world.w;
	float depth = -world_pos.z + VERTEX.z;

	float depth_factor = clamp(depth / depth_distance, 0.0, 1.0);
	vec4 final_color = mix(shallow_color, deep_color, depth_factor);

	ALBEDO = final_color.rgb;
	ALPHA = final_color.a;
	ROUGHNESS = 0.1;
	SPECULAR = 0.6;
}
