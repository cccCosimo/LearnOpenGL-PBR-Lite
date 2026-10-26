#version 330 core
in vec3 ourColor;
in vec2 TexCoord;

out vec4 FragColor;

uniform sampler2D ourTexture1;
uniform sampler2D ourTexture2;

void main()
{
    vec4 texColor1 = texture(ourTexture1, TexCoord);
    vec4 texColor2 = texture(ourTexture2, TexCoord);
    FragColor = mix(mix(texColor1, texColor2, 0.6), vec4(ourColor, 1.0), 0.2);
}