d = mirror_Domain; % for point IDs
fig(1) = figure(1);clf;
for shapeID=1:4
FV = mirror_ffd_Express(0.3+0.4*rand(1,41), d.FfdP);
feature(1) = getTotalCurvature(FV.vertices, d);
[feature(2), maxVertex, minVertex, maxVertexID, minVertexID] = getLength(FV.vertices, d);
feature(3) = getMirrorSurface(FV.vertices, d);

subplot(2,2,shapeID);
h(1) = patch('Vertices',FV.vertices','Faces',FV.faces, 'FaceAlpha',0.9,'FaceColor', [0.7 0.7 0.7], 'LineStyle', 'none');
hold on;
% Plot curvature lines
for i=1:length(d.features.curvature.ids)
    pp = FV.vertices(:,d.features.curvature.ids{i});
    h(2) = scatter3(pp(1,:),pp(2,:),pp(3,:),32,'r','filled');
end
% Plot relative length
pp = FV.vertices(:,[minVertexID, maxVertexID]);
h(3) = scatter3(pp(1,:),pp(2,:),pp(3,:),128,'g','filled');

% Plot area 
pp = FV.vertices(:,d.features.mirror.ids);
pp = [pp pp(:,1)];
h(4) = plot3(pp(1,:),pp(2,:),pp(3,:),'k','LineWidth',4);

legend([h(1) h(2) h(3) h(4)],'Mirror', 'Curvature', 'Relative Length', 'Mirror Area');
title(['Features: ' num2str(feature(1),3) ' - ' num2str(feature(2),3) ' - ' num2str(feature(3),3)]);

lightangle(-65, 20);
lighting phong; light; material metal;
view(-50,30);
grid on;
xlabel('x');ylabel('y');zlabel('z');
axis([700 1100 -1100 -700 600 800]);
end


%save_figures(fig, './', ['feature_visualization_'], 12, [16 10]);
