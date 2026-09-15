shader_type canvas_item;

uniform float threshold: hint_range(0.0, 1.0) = 0.7;
uniform vec4 tint_color: source_color = vec4(1.0, 0.0, 0.0, 1.0);

void fragment() {
	vec4 original = texture(TEXTURE, UV);
	
	if(UV.x > threshold){
		COLOR = vec4(tint_color.rgb, original.a);
	}
	else{
		COLOR = original;
	}
}
