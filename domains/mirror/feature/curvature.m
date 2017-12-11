% Visualize
figure(1);
plot3(FV{shapeID}.vertices(1,:),FV{shapeID}.vertices(2,:),FV{shapeID}.vertices(3,:),'x');
view(107,90);


figure(2);hold on;
plot3(back(:,1), back(:,2),back(:,3),'x');
view(115,0);
%
hold on;
scatter3(line1(:,1),line1(:,2),line1(:,3),'filled');
scatter3(line2(:,1),line2(:,2),line2(:,3),'filled');
scatter3(line3(:,1),line3(:,2),line3(:,3),'filled');
scatter3(line4(:,1),line4(:,2),line4(:,3),'filled');
scatter3(line5(:,1),line5(:,2),line5(:,3),'filled');
%

xlabel('x');ylabel('y');zlabel('z');
%view(-270,0);
grid on;
axis equal;

%% Find IDs
[~,index_InMesh] = intersect(FV{shapeID}.vertices',back,'rows')


[~,indexLine] = intersect(back,line1,'rows')
linIndices{1} = index_InMesh(indexLine)'
[~,ii] = intersect(back,line2,'rows')
linIndices{2} = index_InMesh(ii)'
indexLine = [indexLine;ii];
[~,ii] = intersect(back,line3,'rows')
linIndices{3} = index_InMesh(ii)'
indexLine = [indexLine;ii];
[~,ii] = intersect(back,line4,'rows')
linIndices{4} = index_InMesh(ii)'
indexLine = [indexLine;ii];
[~,ii] = intersect(back,line5,'rows')
linIndices{5} = index_InMesh(ii)'
indexLine = [indexLine;ii];

%% Visualize random shapes and curvature
if ~exist('curvs','var')
    for ii=1:1000
        [FV{shapeID}, ~, ffdP{shapeID}] = ...
            mirror_ffd_Express(0.5 + 0.2*randn(1,41), 'mirrorBase.stl');
        %[FV{shapeID}, ~, ffdP{shapeID}] = ...
        %    mirror_ffd_Express(0.5 - 0.2*ones(1,41), 'mirrorBase.stl');
        
        % figure(3);
        % hold off;
        % plot3(FV{shapeID}.vertices(1,:),FV{shapeID}.vertices(2,:),FV{shapeID}.vertices(3,:),'x');
        % hold on;
        % for i=1:5
        % scatter3(FV{shapeID}.vertices(1,linIndices{i}),FV{shapeID}.vertices(2,linIndices{i}),FV{shapeID}.vertices(3,linIndices{i}),'filled');
        % end
        % %
        for i=1:5
            line = FV{shapeID}.vertices(:,linIndices{i});
            % Ratio between line length and length between start and end point
            startToEnd(i) = pdist2(line(:,1)',line(:,end)');
            curv(i) = sum(diag(squareform(pdist(line')),1))/startToEnd(i);
        end
        for i=1:5
            line = FV{shapeID}.vertices(:,linIndices{i});
            curv(i) = curv(i)/max(startToEnd);
            %     text(line(1,1),line(2,1),line(3,1),num2str(curv(i)),'FontSize',14)
        end
        title(['Total Curvature Approximation: ' num2str(sum(curv))]);
        disp(['Total Curvature Approximation: ' num2str(sum(curv))]);
        
        curvs(ii) = sum(curv);
    end
end
figure(4);
histogram(curvs,'Normalization','pdf');xlabel('Total Curvature');ylabel('pdf');title('Curvature of 1000 random samples');grid on;

%% Get some random shapes and show curvature
fig(1) = figure(5);
for ii=1:8
    subplot(4,2,ii);
    hold off;
    [FV{ii}, ~, ffdP{ii}] = ...
        mirror_ffd_Express(0.5 + ii*0.03*randn(1,41), 'mirrorBase.stl');
    scatter3(FV{ii}.vertices(1,:), FV{ii}.vertices(2,:),FV{ii}.vertices(3,:),4,'filled');
    view(-30,10);
    hold on;

    for i=1:5
        line = FV{ii}.vertices(:,linIndices{i});
        % Ratio between line length and length between start and end point
        startToEnd(i) = pdist2(line(:,1)',line(:,end)');
        curv(i) = sum(diag(squareform(pdist(line')),1))/startToEnd(i);
        scatter3(line(1,:),line(2,:),line(3,:),'filled');
    end
    for i=1:5
        line = FV{ii}.vertices(:,linIndices{i});
        curv(i) = curv(i)/max(startToEnd);
        %     text(line(1,1),line(2,1),line(3,1),num2str(curv(i)),'FontSize',14)
    end
    
    title(['' num2str(sum(curv))]);
    disp(['Total Curvature Approximation: ' num2str(sum(curv))]);
    drawnow;
    
end

save_figures(fig, './', ['fff_'], 12, [10 6]);