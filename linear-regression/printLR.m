%% Linear Regression 
clear all
[nombre,carpeta]=uigetfile('*.csv');
if isequal(nombre,0)|| isequal(carpeta,0)
    return;
end 
%%
data = load(strcat(carpeta,nombre));
X = data(:, 1:2);
y = data(:, 3);

fprintf('\n')
fprintf('\n')

figure
scatter3(X(:, 1), X(:, 2), y, [], y(:), 'o');
title('Training Set');
xlabel('Size');
ylabel('Rooms');
zlabel('Price');

lambda = 0;

alpha = 0.1;
num_iterations = 50;
[theta mu sigma X_normalized J_history] = linear_regression_train(X, y, alpha, lambda, num_iterations);

disp('- Initial cost:');
disp(J_history(1))
fprintf('\n')
disp('- Optimized cost:');
disp(J_history(end))
disp('- Theta (with normalization):');
disp(theta);

X_normal = [ones(size(X, 1), 1) X];
theta_normal = normal_equation(X_normal, y);
normal_cost = cost_function(X_normal, y, theta_normal, lambda);

disp('Normal function cost:');
disp(normal_cost)
disp('- Theta (without normalization):');
disp(theta_normal);

apt_sizes = X_normalized(:, 2);
apt_rooms = X_normalized(:, 3);
apt_size_range = linspace(min(apt_sizes), max(apt_sizes), 10);
apt_rooms_range = linspace(min(apt_rooms), max(apt_rooms), 10);

apt_prices = zeros(length(apt_size_range), length(apt_rooms_range));
for apt_size_index = 1:length(apt_size_range)
    for apt_room_index = 1:length(apt_rooms_range)
        X = [1, apt_size_range(apt_size_index), apt_rooms_range(apt_room_index)];
        apt_prices(apt_size_index, apt_room_index) = hypothesis(X, theta);
    end
end

% Plot the plane on top of training data to see how it feets them.

figure
scatter3(X_normalized(:, 2), X_normalized(:, 3), y, [], y(:), 'o');
title('Normalized Training Set');
xlabel('Normalized Size');
ylabel('Normalized Rooms');
zlabel('Price');
hold on
mesh(apt_size_range, apt_rooms_range, apt_prices);
legend('Training Examples', 'Hypothesis Plane')
hold off

figure
plot(1:num_iterations, J_history);
xlabel('Iteration');
ylabel('J(\theta)');
title('Gradient Descent Progress');