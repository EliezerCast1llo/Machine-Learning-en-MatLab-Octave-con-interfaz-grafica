%% K-Means
[nombre1,carpeta1]=uigetfile('*.mat');
if isequal(nombre1,0)|| isequal(carpeta1,0)
    return;
else
    [nombre2,carpeta2]=uigetfile('*.mat');
if isequal(nombre2,0)|| isequal(carpeta2,0)
    return;
else
end
end
%%
load(strcat(carpeta1,nombre1));
figure
plot(X(:, 1), X(:, 2), 'k+','LineWidth', 1, 'MarkerSize', 7);
title('Training Set #1');

K = 3; 
max_iterations = 20;
[centroids, closest_centroids_ids] = k_means_train(X, K, max_iterations);


figure
for k=1:K
    cluster_x = X(closest_centroids_ids == k, :);
    plot(cluster_x(:, 1), cluster_x(:, 2), '+');
    hold on;

    centroid = centroids(k, :);
    plot(centroid(:, 1), centroid(:, 2), 'ko', 'MarkerFaceColor', 'r', 'MarkerSize', 8);
    hold on;
end
title('Clustered Set #1');
hold off;

load(strcat(carpeta2,nombre2));

figure
plot(X(:, 1), X(:, 2), 'k+','LineWidth', 1, 'MarkerSize', 7);
title('Training Set #2');

K = 3; 
max_iterations = 20; 
[centroids, closest_centroids_ids] = k_means_train(X, K, max_iterations);

figure
for k=1:K
    
    cluster_x = X(closest_centroids_ids == k, :);
    plot(cluster_x(:, 1), cluster_x(:, 2), '+');
    hold on;

    centroid = centroids(k, :);
    plot(centroid(:, 1), centroid(:, 2), 'ko', 'MarkerFaceColor', 'r', 'MarkerSize', 8);
    hold on;
end
title('Clustered Set #2');
hold off;