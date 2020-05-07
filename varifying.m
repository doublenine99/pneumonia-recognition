clear; clc; close all;
phe_path = 'C:\Users\pjj85\OneDrive - UW-Madison\2020 Spring\CS 567\567 final project\PNEUMONIA\';
% normal_path = 'C:\Users\pjj85\OneDrive - UW-Madison\2020 Spring\CS 567\567 final project\test\NORMAL\';
verifying_vector = calculate_ratio(phe_path, 'pne')
 
m = 0.4100;
sd = 0.0601;

%perform Z-test
pred = predict(verifying_vector, m, sd)
acc = pred ./ size(verifying_vector, 1)

output_name = sprintf('verifying_vector.out');
output_file = fopen(output_name, 'w');


fprintf(output_file, "verifying vector is: \n");
fprintf(output_file, "%f\n", verifying_vector);

fprintf(output_file, "predicated successful number is: %f\n", pred);
fprintf(output_file, "accuracy is: %f", acc);