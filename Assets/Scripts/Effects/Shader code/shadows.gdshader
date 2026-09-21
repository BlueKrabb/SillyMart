shader_type canvas_item;
uniform bool look_right = true;

uniform vec4 shadow_color: source_color = vec4(0.9176, 0.0, 0.0, 0.502);
uniform float shadow_opacity : hint_range(0.0, 1.0) = 0.5;

void vertex() {
	VERTEX.x = VERTEX.x * { -1.0, 1.0 }[int(look_right)];
		
	float xSkewRatio = step(UV.y, .5);
	vec2 skewTransition = vec2(abs(VERTEX.x) * xSkewRatio, 0.0);
	vec2 skewScale = vec2(VERTEX.x, (VERTEX.y + abs(VERTEX.y)) / 2.0);
	
	VERTEX = skewScale;

	VERTEX = VERTEX + skewTransition;
}

void fragment() {
	COLOR = vec4(shadow_color.rgb, shadow_color.a * shadow_opacity * COLOR.a);
}