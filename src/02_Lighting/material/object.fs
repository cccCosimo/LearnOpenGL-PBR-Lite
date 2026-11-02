#version 330 core
in vec3 Normal;
in vec3 FragPos;

out vec4 FragColor;

struct Material {
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
    float shininess;
};
struct Light {
    vec3 position;

    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};
uniform Material material;
uniform Light light;
uniform vec3 viewPos;

void main()
{
    // ambient lighting
    vec3 ambient = light.ambient * material.ambient;

    // diffuse lighting
    vec3 norm = normalize(Normal);
    vec3 lightDir = normalize(light.position - FragPos);
    float diff = max(dot(lightDir, norm), 0.0f);
    vec3 diffuse = light.diffuse * (material.diffuse * diff);

    // specular lighting
    vec3 viewDir = normalize(viewPos - FragPos);
    vec3 reflectDir = reflect(-lightDir, norm);
    float spec = pow(max(dot(viewDir, reflectDir), 0), material.shininess);
    vec3 specular = light.specular * (material.specular * spec);

    // conbined (Phong lighting model)
    vec3 result = ambient + diffuse + specular;
    FragColor = vec4(result, 1.0f);
}