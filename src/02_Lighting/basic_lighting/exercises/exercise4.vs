#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aNormal;

out vec3 ambient;
out vec3 diffuse;
out vec3 specular;

uniform vec3 lightColor;
uniform vec3 lightPos;
uniform vec3 viewPos;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

void main()
{
    // ambient lighting
    float ambientStrength = 0.1f;
    ambient = ambientStrength * lightColor;

    // diffuse lighting
    float diffuseStrength = 1.0f;
    vec3 Normal = mat3(transpose(inverse(model))) * aNormal;
    vec3 norm = normalize(Normal);
    vec3 FragPos = vec3(model * vec4(aPos, 1.0f));
    vec3 lightDir = normalize(lightPos - FragPos);
    float diff = max(dot(lightDir, norm), 0);
    diffuse = diffuseStrength * diff * lightColor;

    // specular lighting
    float specularStrength = 2.0f;
    vec3 viewDir = normalize(viewPos - FragPos);
    vec3 reflectDir = reflect(-lightDir, norm);
    float spec = pow(max(dot(viewDir, reflectDir), 0), 32);
    specular = specularStrength * spec * lightColor;  

    gl_Position = projection * view * model * vec4(aPos, 1.0f);
}