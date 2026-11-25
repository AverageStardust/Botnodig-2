shader_type canvas_item;

uniform sampler2D screen_tex : hint_screen_texture, filter_linear;
uniform vec3 background_color : source_color = vec3(0.0);
uniform vec3 tile_color : source_color = vec3(0.5);
uniform vec3 sprite_color : source_color = vec3(1.0);

void fragment() {
    vec3 screen_color = texture(screen_tex, SCREEN_UV).rgb;
	float brightness = (screen_color.r + screen_color.g + screen_color.b) / 3.0;
	
	if (brightness < 0.5) {
    	COLOR = vec4(mix(background_color, tile_color, brightness * 2.0), 1.0);
	} else {
    	COLOR = vec4(mix(tile_color, sprite_color, brightness * 2.0 - 1.0), 1.0);
	}
}
