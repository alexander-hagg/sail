d = mirror_Domain; % for point IDs

for i=1:10000
    FV{i} = mirror_ffd_Express(rand(1,41), d.FfdP);
    tic;
    feature(i,1) = getTotalCurvature(FV{i}.vertices, d);
    time(i,1) = toc;tic;
    feature(i,2) = getLength(FV{i}.vertices, d);
    time(i,2) = toc;tic;
    feature(i,3) = getMirrorSurface(FV{i}.vertices, d);
    time(i,3) = toc;
end
%%
fig(1) = figure(1);
%%
nbins = 100;
figure(1);
subplot(3,1,1);
sel = (feature(:,1) > min(feature(:,1))) & (feature(:,1) < 5000);
hist(feature(sel,1)',nbins);
axis([min(feature(:,1)) 5000 0 400]);
grid on;
title('Features of 10000 random samples');
ylabel('Curvature');
subplot(3,1,2);
sel = (feature(:,2) > 55) & (feature(:,2) < 1.2e2); 
hist(feature(sel,2)',nbins);
axis([55 120 0 250]);
grid on;
ylabel('Length');
subplot(3,1,3);
sel = feature(:,3) < 5e4; 
hist(feature(sel,3)',nbins);
axis([0 5e4 0 300]);
grid on;
ylabel('MirrorSurface');


save_figures(fig, './', ['feature_sampling_'], 12, [7 5]);
