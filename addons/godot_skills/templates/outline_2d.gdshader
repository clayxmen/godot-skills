// res://assets/shaders/outline_2d.gdshader
shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float outline_width : hint_range(0.0, 10.0, 1.0) = 1.0;
uniform bool is_active = true;

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	
	if (!is_active || col.a > 0.5) {
		COLOR = col;
		return;
	}

	vec2 size = TEXTURE_PIXEL_SIZE * outline_width;
	float max_alpha = 0.0;

	max_alpha = max(max_alpha, texture(TEXTURE, UV + vec2(0.0, -size.y)).a);
	max_alpha = max(max_alpha, texture(TEXTURE, UV + vec2(0.0, size.y)).a);
	max_alpha = max(max_alpha, texture(TEXTURE, UV + vec2(-size.x, 0.0)).a);
	max_alpha = max(max_alpha, texture(TEXTURE, UV + vec2(size.x, 0.0)).a);
	max_alpha = max(max_alpha, texture(TEXTURE, UV + vec2(-size.x, -size.y)).a);
	max_alpha = max(max_alpha, texture(TEXTURE, UV + vec2(size.x, -size.y)).a);
	max_alpha = max(max_alpha, texture(TEXTURE, UV + vec2(-size.x, size.y)).a);
	max_alpha = max(max_alpha, texture(TEXTURE, UV + vec2(size.x, size.y)).a);

	if (max_alpha > 0.5) {
		COLOR = outline_color;
	} else {
		COLOR = col;
	}
}
