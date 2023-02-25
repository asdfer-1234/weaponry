/*shader_type canvas_item;

uniform vec3 yellow = vec3(1.0, 0.85, 0.54);
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_linear_mipmap;

void fragment() {
	vec4 bg = texture(screen_texture, SCREEN_UV);
	vec4 fg = texture(TEXTURE, UV);
	
	if(bg.r + bg.g + bg.b >= 1.0){
		COLOR = vec4(yellow, fg.a);
	}
	else{
		COLOR = fg;
	}
}
*/
shader_type canvas_item;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_linear_mipmap;
void fragment(){
	
	vec4 color = vec4(texture(screen_texture, SCREEN_UV).rgb, texture(TEXTURE, UV).a);
	
	COLOR = vec4(1.0 - color.rgb,  color.a);
}