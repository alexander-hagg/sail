% Vertices of bounding box
vertices = [0.2 0.0 0.0;  0.5 0.0 0.0;  0.3 0.5 0.0;  0.0 0.5 0.0; 
            0.0 0.0 0.5;  0.5 0.0 0.5;  0.3 0.5 0.5;  0.0 0.4 0.4]
tetra = delaunayn(vertices)
faces = freeBoundary(TriRep(tetra,vertices)); % use free boundary as triangulation

heavytest = 0;

xyz = 0.5*rand(500,3); % Generate random points

in = intriangulation(vertices,faces,xyz,heavytest)

fig(1) = figure(3); hold off;
scatter3(xyz(:,1),xyz(:,2),xyz(:,3),64,in.*[1 0 0],'filled');
hold on;

%plot3(vertices(faces(:),1),vertices(faces(:),2),vertices(faces(:),3),'x-','LineWidth',4);
for v=1:size(faces,1)
    plot3(vertices(faces(v,:),1),vertices(faces(v,:),2),vertices(faces(v,:),3),'x-','LineWidth',4);
end
for i=1:size(vertices,1)
    text(vertices(i,1),vertices(i,2),vertices(i,3),int2str(i),'FontSize',14);
end

xlabel('x');ylabel('y');zlabel('z');

%save_figures(fig, './', ['boundingbox_test_'], 12, [8 8]);