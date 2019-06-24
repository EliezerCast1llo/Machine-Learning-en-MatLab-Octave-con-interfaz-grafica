%% Logistic Regression 
clear all
[nombre,carpeta]=uigetfile('*.csv');
if isequal(nombre,0)|| isequal(carpeta,0)
    return;
end 
%%

data = load(strcat(carpeta,nombre));

X = data(:, 1:2);
y = data(:, 3);

positiveIndices = find(y == 1);
negativeIndices = find(y == 0);

figure
hold on;
plot(X(positiveIndices, 1), X(positiveIndices, 2), 'k+', 'LineWidth', 2, 'MarkerSize', 7);
plot(X(negativeIndices, 1), X(negativeIndices, 2), 'ko', 'MarkerFaceColor', 'y', 'MarkerSize', 7);

xlabel('Microchip Test 1');
ylabel('Microchip Test 2');
legend('y = 1', 'y = 0');


polynomial_degree = 6;
X = add_polynomial_features(X(:, 1), X(:, 2), polynomial_degree);

lambda = 1;
[theta, J, J_history, exit_flag] = logistic_regression_train(X, y, lambda);

disp('Initial cost:');
disp(J_history(1))
disp('Optimized cost:');
disp(J)

u = linspace(-1, 1, 50);
v = linspace(-1, 1, 50);
z = zeros(length(u), length(v));
for i = 1:length(u)
    for j = 1:length(v)
        x = add_polynomial_features(u(i), v(j), polynomial_degree);
        x = [ones(size(x, 1), 1), x];
        z(i, j) = x * theta;
    end
end

z = z';

contour(u, v, z, [0, 0], 'LineWidth', 2);
title(sprintf('lambda = %g', lambda));
legend('y = 1', 'y = 0', 'Decision boundary');

hold off;

x = [
    0, 0;
    -0.5, -0.5
];

x = add_polynomial_features(x(:, 1), x(:, 2), polynomial_degree);

x = [ones(size(x, 1), 1), x];

probabilities = hypothesis(x, theta);
disp('Probabilities');
disp(probabilities);