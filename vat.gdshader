shader_type spatial;

uniform sampler2D offTex;
uniform float scale = 0.0;
uniform float frame;
uniform float colorRange;
uniform float midPoint;
uniform vec3 low_color : source_color;
uniform vec3 mid_color : source_color;
uniform vec3 high_color : source_color;

varying float offset;

float unMix(float a, float b, float v) {
  return (v - a) / (b - a);
}

void vertex() {
	offset = texture(offTex, UV2 + vec2(0.0, frame)).r;
  float no = offset * 2.0 - 1.0;
  no *= scale;
  VERTEX += no * NORMAL;
}

void fragment() {
  float co = colorRange * 0.5;
  vec3 col = vec3(0.0);
  vec3 em = vec3(0.0);
  if (offset < midPoint) {
    col = mix(low_color, mid_color, clamp(unMix(midPoint-co, midPoint, offset), 0.0, 1.0));
    em = mix(vec3(0.0), mid_color, clamp(unMix(midPoint-co, midPoint, offset), 0.0, 1.0));
  } else {
    col = mix(mid_color, high_color, clamp(unMix(midPoint, midPoint+co, offset), 0.0, 1.0));
    em = col;
  }
  EMISSION = em;
  ALBEDO = col;
  METALLIC = 1.0;
  ROUGHNESS = 0.5;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
