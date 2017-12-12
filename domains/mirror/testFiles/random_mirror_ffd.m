numShapes = 1;
for shapeID=1:numShapes
    disp(['Generating shape ' int2str(shapeID) '/' int2str(numShapes)]);
    [FV{shapeID}, ~, ffdP{shapeID}] = mirror_ffd_Express(0.5 + shapeID*0.00*randn(1,41), 'mirrorBase.stl');
end

%%

for shapeID=1:numShapes
    disp(['Displaying shape ' int2str(shapeID) '/' int2str(numShapes)]);
    
    controlPtsX = 0:1/(ffdP{shapeID}.nDimX-1):1;
    controlPtsY = 0:1/(ffdP{shapeID}.nDimY-1):1;
    controlPtsZ = 0:1/(ffdP{shapeID}.nDimZ-1):1;
    controlPts = combvec(controlPtsX,controlPtsY,controlPtsZ);
    controlPts = controlPts.*repmat((ffdP{shapeID}.maxMeshPoint-ffdP{shapeID}.minMeshPoint)',1,size(controlPts,2)) + repmat(ffdP{shapeID}.minMeshPoint',1,size(controlPts,2));
    controlPts = controlPts' * ffdP{shapeID}.rotMat';
    controlPts = mapminmax('reverse', controlPts',ffdP{shapeID}.normalizationFactors);
    
    figure(1);
    subplot(1,2,1);hold off;
    title('Showing random mirrors with increasing parameters');
    plotmesh(FV{shapeID}.vertices',FV{shapeID}.faces);
    hold on;
    % Plot control points
    hold on;
    scatter3(controlPts(1,:),controlPts(2,:),controlPts(3,:),'filled');
    xlabel('x');ylabel('y');zlabel('z');
    view(-270,20);
    grid on;
    axis equal;axis tight
    
    subplot(1,2,2);hold off;
    plotmesh(FV{shapeID}.vertices',FV{shapeID}.faces);
    hold on;
    % Plot control points
    hold on;
    scatter3(controlPts(1,:),controlPts(2,:),controlPts(3,:),'filled');
    xlabel('x');ylabel('y');zlabel('z');
    view(-15,20);
    grid on;
    axis equal;axis tight
    
    %%
    
    figure(2);
    plot3(FV{shapeID}.vertices(1,:),FV{shapeID}.vertices(2,:),FV{shapeID}.vertices(3,:),'x');
    hold on;
    % Plot control points
    hold on;
    scatter3(controlPts(1,:),controlPts(2,:),controlPts(3,:),'filled');
    xlabel('x');ylabel('y');zlabel('z');
    view(-270,30);
    grid on;
    axis equal;
    drawnow;
    
end


%%
save_figures(fig, './', ['mirror_curvature_'], 12, [5 5]);
