// res://assets/shaders/toon_shading_3d.gdshader
shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_toon, specular_toon;

uniform vec4 base_color : source_color = vec4(0.8, 0.3, 0.2, 1.0);
uniform sampler2D albedo_texture : source_color, filter_linear_mipmap;
uniform float cuts : hint_range(1.0, 8.0, 1.0) = 3.0;
uniform float specular_size : hint_range(0.0, 1.0, 0.01) = 0.1;
uniform float specular_smoothness : hint_range(0.0, 0.1, 0.001) = 0.01;

void fragment() {
	vec4 tex = texture(albedo_texture, UV);
	ALBEDO = base_color.rgb * tex.rgb;
	ROUGHNESS = 0.8;
}

void light() {
	float NdotL = dot(NORMAL, LIGHT);
	float light_intensity = clamp((NdotL + 1.0) * 0.5, 0.0, 1.0);
	float stepped_light = floor(light_intensity * cuts) / cuts;

	vec3 H = normalize(LIGHT + VIEW);
	float NdotH = dot(NORMAL, H);
	float spec = smoothstep(1.0 - specular_size - specular_smoothness, 1.0 - specular_size, NdotH);

	DIFFUSE_LIGHT += LIGHT_COLOR * ALBEDO * stepped_light * ATTENUATION;
	SPECULAR_LIGHT += LIGHT_COLOR * spec * ATTENUATION;
}
