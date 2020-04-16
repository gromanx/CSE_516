% Gladys Roman
% CSE 516 K-MEANS LAB
% Winter 2020

X = load('s1.dat');

K = 7;
epoch = 20;

%centroids = initCentroids(X, K);
centroids1 = zeros(K, size(X, 2));
randidx = randperm(size(X, 1));
centroids1 = X(randidx(1: K), :);

for i = i : epoch
    %indices = reassignPoints(X, centroids)
    K = size(centroids1, 1);
    indices = zeros(size(X, 1), 1);
    m = size(X, 1);
    
    for j = 1 : m
        k = 1;
        min_dist = sum((X(j,:) - centroids1 (1,:)) .^2);
        for n = 2 : K
            dist = sum((X(j,:) - centroids1 (n,:)) .^2);
            if(dist < min_dist)
                min_dist = dist;
                k = n;
            end
        end
        indices(j) = k;
    end
    
    %centroids = updateCentroidsX, indices, K);
    [m, n] = size(X);
    centroids1 = zeros(K, n);
    
    for j = 1 : K
        x1 = X(indices == j, :);
        ck = size(x1, 1);
        centroids1(j, :) = (1/ck) * [sum(x1(:, 1)) sum(x1(:, 2))];
    end
end

scatter(X(:,1), X(:,2), 32, indices, 'filled')