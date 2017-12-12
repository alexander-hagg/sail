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