[FV, validity, ffdP] = mirror_ffd_Express(0.5 + 0.1*randn(1,40), 'mirrorBase.stl');

controlPtsX = 0:1/(ffdP.nDimX-1):1;
controlPtsY = 0:1/(ffdP.nDimY-1):1;
controlPtsZ = 0:1/(ffdP.nDimZ-1):1;
controlPts = combvec(controlPtsX,controlPtsY,controlPtsZ);
controlPts = controlPts.*repmat((ffdP.maxMeshPoint-ffdP.minMeshPoint)',1,size(controlPts,2)) + repmat(ffdP.minMeshPoint',1,size(controlPts,2));
controlPts = controlPts' * ffdP.rotMat';
controlPts = mapminmax('reverse', controlPts',ffdP.normalizationFactors);

figure(1);
subplot(2,2,1);hold off;
plot(FV.vertices(1,:),FV.vertices(2,:),'x');
hold on;
scatter(controlPts(1,:),controlPts(2,:),'filled');
axis equal;
grid on;
xlabel('x');ylabel('y');

subplot(2,2,2);hold off;
plot(FV.vertices(1,:),FV.vertices(3,:),'x');
hold on;
scatter(controlPts(1,:),controlPts(3,:),'filled');
xlabel('x');ylabel('z');
grid on;
axis equal;

subplot(2,2,3);hold off;
plot(FV.vertices(2,:),FV.vertices(3,:),'x');
hold on;
scatter(controlPts(2,:),controlPts(3,:),'filled');
xlabel('y');ylabel('z');
grid on;
axis equal;
%
subplot(2,2,4);hold off;
plot3(FV.vertices(1,:),FV.vertices(2,:),FV.vertices(3,:),'x');
hold on;
% Plot control points
hold on;
scatter3(controlPts(1,:),controlPts(2,:),controlPts(3,:),'filled');
xlabel('x');ylabel('y');zlabel('z');
grid on;
axis equal;
