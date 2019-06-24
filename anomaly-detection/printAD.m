%% Anomaly Detection
clear all
load C:\Matlab\Data\VarAnomalyDetection.mat X Xval yval epsilon F1
%%
fprintf('\n')
fprintf('\n')

disp ('Best epsilon found using cross-validation:')
disp (epsilon)
disp ('Best F1 on Cross Validation Set:')
disp (F1)

fprintf('\n')
fprintf('\n')
% Grafica

[mu sigma2] = estimate_gaussian(X);

    [X1, X2] = meshgrid(0:.5:35); 
    Z = multivariate_gaussian([X1(:) X2(:)], mu, sigma2);
    Z = reshape(Z, size(X1));   

probabilities = multivariate_gaussian(X, mu, sigma2);

[epsilon F1] = select_threshold(yval, probabilities);

outliers = find(probabilities < epsilon);

figure
hold on
plot(X(:, 1), X(:, 2),'bx');
legend('Training set', 'Gaussian contour', 'Anomalies');
xlabel('Latency (ms)');
ylabel('Throughput (mb/s)');
title('Servers Parameters');
    if (sum(isinf(Z)) == 0)
        contour(X1, X2, Z, 10 .^ (-20:3:0)');
    end
plot(X(outliers, 1), X(outliers, 2), 'ro', 'LineWidth', 2, 'MarkerSize', 10);

