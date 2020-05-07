clear; clc; close all;
normal_path = 'C:\Users\pjj85\OneDrive - UW-Madison\2020 Spring\CS 567\567 final project\NORMAL\';
normal_vector = calculate_ratio(normal_path, 'normal')
m = mean(normal_vector)
sd = std(normal_vector)

output_name = sprintf('normal_vector.out');
output_file = fopen(output_name, 'w');


fprintf(output_file, "normal vector is: \n");
fprintf(output_file, "%f\n", normal_vector);

fprintf(output_file, "mean is: %f\n", m);
fprintf(output_file, "standard deviation is: %f", sd);

