shader_type canvas_item;

uniform sampler2D noise: repeat_enable;
uniform vec4 color : source_color;
uniform sampler2D gradient: source_color;

void fragment() {
	vec2 uv = vec2(UV.x + TIME * 0.5, UV.y + TIME * 0.5);
	
	COLOR.rgb = (texture(noise, uv).rgb + texture(gradient, uv).rgb)*0.5;
	COLOR.a = color.a;
}
