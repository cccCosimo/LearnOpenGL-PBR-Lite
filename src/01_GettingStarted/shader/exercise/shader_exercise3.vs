#version 330 core
layout (location = 0) in vec3 aPos;

out vec3 ourColor;

void main()
{
    gl_Position = vec4(aPos, 1.0);
    ourColor = aPos;
}

// the bottom left side of our triangle is black because the color vector is (-0.5, -0.5, 0.0, 1.0), 
// I think shader would've considered it as (0, 0, 0, 1.0), since the element of color vector must be nonnegative