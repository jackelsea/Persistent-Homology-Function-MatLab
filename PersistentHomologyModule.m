function PerHom = GetHomology(image,steps,stepsize)

PerHom = zeros(3,steps);
Use_img = imread(image);
    figure(1); imshow(Use_img);
    hold on;

%creates keypoints
Use_GryImg = rgb2gray(Use_img);
Use_RefPts = detectSIFTFeatures(Use_GryImg);
[ref_features, ref_validPts] = extractFeatures(Use_GryImg, Use_RefPts);
Use_strongest25 = Use_RefPts.selectStrongest(25);

%displays card and keypoints
hold on;
plot(Use_strongest25);

%relevant tables
A = Use_strongest25.Location;
D = zeros(1,400);

%finds which keypoints are connected over each radius
for r = 1:steps
    PerHom(1,r) = stepsize * r;
for i = 1:20^2 
    b = mod(i,20);

    if b == 0
        h = 20;
    else
        h = b;
    end
    w = i/20;
    j = ceil(w);
    x_0 = A(j,1);
    y_0 = A(j,2);
    x_1 = A(h,1);
    y_1 = A(h,2);
    a = (x_0 - x_1)^2;
    b = (y_0 - y_1)^2;
    dpre = (a + b)^0.5;
    if dpre > (0.4 * r)
        D(i) = 0;
    else
        D(i) = dpre;
    end
    if D(i) > 0
    end
end
D = reshape(D,20,20);

%finds H_0
G = graph(D);
H_0 = max(conncomp(G));
PerHom(2,r) = H_0;

%finds H_1
H_1 = 0;
cycles = cyclebasis(G);
for i = 1:numel(cycles)
    M = cell2mat(cycles(i));
    if numel(M) == 4
        if D(M(1),M(3)) == 0
            if D(M(2),M(4)) == 0
                H_1 = H_1 + 1;
            end
        end
    end
end
PerHom(3,r) = H_1;

end

hold off
end
hold off
