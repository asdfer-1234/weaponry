shader_type canvas_item;

uniform vec4 outline_color;

bool notAlpha(vec4 color){
	return color.a > 0.5;
}

const vec2 adjacent[8] = {vec2(0, 1), vec2(0, -1), vec2(1, 0), vec2(-1, 0), vec2(1, 1), vec2(-1, 1), vec2(1, -1), vec2(-1, -1)};

void fragment(){
	
	vec2 pixelSize = 1.0 / vec2(textureSize(TEXTURE, 0));
	
	if(notAlpha(texture(TEXTURE, UV))){
		COLOR = texture(TEXTURE, UV);
	}
	else{
		bool border = false;
		for(int i = 0; i < 8; i++){
			vec2 targetUV = UV;
			targetUV += pixelSize * adjacent[i];
			if(notAlpha(texture(TEXTURE, targetUV))){
				border = true;
				break;
			}
		}
		if(border){
			COLOR = outline_color;
		}
		else{
			COLOR = texture(TEXTURE, UV);
		}
	}
}