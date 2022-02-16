 
// Used a bigger poisson disk kernel than in the tutorial to get smoother results
const vec2 poissonDisk[9] = vec2[] (
    vec2(0.95581, -0.18159), vec2(0.50147, -0.35807), vec2(0.69607, 0.35559),
    vec2(-0.0036825, -0.59150), vec2(0.15930, 0.089750), vec2(-0.65031, 0.058189),
    vec2(0.11915, 0.78449), vec2(-0.34296, 0.51575), vec2(-0.60380, -0.41527)
);

// Unpack the 16bit depth float from the first two 8bit channels of the rgba vector
float unpackDepth(vec4 color) {
    return color.r + color.g / 255.0;
}

uniform sampler2D shadowMap;
//uniform vec3 viewPos;
uniform samplerCube cubeMap;
uniform float fraction;
uniform float render_no;

varying vec4 vertColor;
varying vec3 vertex_normal;
varying vec3 vertex_light_direction;
varying vec4 shadowCoord;
varying float lightIntensity;

varying vec3 Normal;
varying vec3 EyeDir;

float specularStrength = 0.5;



const float Ka = 0.04;
const float Kd = 0.05;
const float Ks = 0.6;
const float n = 50;

vec3 compute_color ( ) {
    float red = 1.0;
    float green = 1.0;
    float blue = 1.0;

    return vec3( red, green, blue );
}

float compute_phong_intensity ( ) {
    float LN = dot( vertex_light_direction, vertex_normal );

    float amibient_reflection = Ka;
    float diffuse_reflection = Kd * max( 0.0, LN );
    float specular_reflection = Ks * pow( LN, n );
    float intensity = amibient_reflection + diffuse_reflection + specular_reflection;
    return intensity;
}


void main(void) {
    float intensity = compute_phong_intensity();
    vec3 color = compute_color();

    // Project shadow coords, needed for a perspective light matrix (spotlight)
    vec3 shadowCoordProj = shadowCoord.xyz / shadowCoord.w;

    // Only render shadow if fragment is facing the light
    if(lightIntensity > 0.5) {
        float visibility = 9.0;

        // I used step() instead of branching, should be much faster this way
        for(int n = 0; n < 9; ++n)
            visibility += step(shadowCoordProj.z, unpackDepth(texture2D(shadowMap, shadowCoordProj.xy + poissonDisk[n] / 512.0)));

        gl_FragColor = vec4(color * intensity * 0.5 + vertColor.rgb * min(visibility * 0.05556, lightIntensity), vertColor.a);
   } else
        gl_FragColor = vec4(color * intensity + vertColor.rgb * lightIntensity, vertColor.a);

    

}
