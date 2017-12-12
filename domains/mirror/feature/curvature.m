[FV, ~, ffdP] = mirror_ffd_Express(0.5 + zeros(1,41), 'mirrorBase.stl');

% Visualize
figure(2);hold off;
plot3(back(:,1), back(:,2),back(:,3),'x');
view(112,90);
%
hold on;
for i=1:length(lines)
scatter3(lines{i}(:,1),lines{i}(:,2),lines{i}(:,3),'filled');
text(lines{i}(1,1),lines{i}(1,2),lines{i}(1,3),['line' int2str(i)]);
plot3(lines{i}([1 end],1),lines{i}([1 end],2),lines{i}([1 end],3));
end
%

xlabel('x');ylabel('y');zlabel('z');
%view(-270,0);
grid on;

%% Find IDs
[~,index_InMesh] = intersect(FV.vertices',back,'rows')
for i=1:length(lines)
    [~,indices] = intersect(back,lines{i},'rows')
    linIndices{i} = index_InMesh(indices)'
end

indexLine = cell2mat(linIndices)
%% Visualize random shapes and curvature
if ~exist('curvs','var')
    for ii=1:1000
        [FV, ~, ffdP] = ...
            mirror_ffd_Express(0.5 + 0.2*randn(1,41), 'mirrorBase.stl');
        % figure(3);
        % hold off;
        % plot3(FV.vertices(1,:),FV.vertices(2,:),FV.vertices(3,:),'x');
        % hold on;
        % for i=1:5
        % scatter3(FV.vertices(1,linIndices{i}),FV.vertices(2,linIndices{i}),FV.vertices(3,linIndices{i}),'filled');
        % end
        % %
        for i=1:5
            line = FV.vertices(:,linIndices{i});
            % Ratio between line length and length between start and end point
            startToEnd(i) = pdist2(line(:,1)',line(:,end)');
            curv(i) = sum(diag(squareform(pdist(line')),1))/startToEnd(i);
        end
        for i=1:5
            line = FV.vertices(:,linIndices{i});
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
for ii=1:9
    subplot(3,3,ii);
    hold off;
    [FV{ii}, ~, ffdP{ii}] = ...
        mirror_ffd_Express(0.5 + ii*0.05*randn(1,41), 'mirrorBase.stl');
    scatter3(FV{ii}.vertices(1,:), FV{ii}.vertices(2,:),FV{ii}.vertices(3,:),4,'filled');
    view(-30,10);
    hold on;
    tic
    for i=1:length(linIndices)
        line = FV{ii}.vertices(:,linIndices{i});
        % Ratio between line length and length between start and end point
        startToEnd(i) = pdist2(line(:,1)',line(:,end)');
        curv(i) = sum(diag(squareform(pdist(line')),1))/startToEnd(i);
        scatter3(line(1,:),line(2,:),line(3,:),'filled');
    end
    toc
    for i=1:length(linIndices)
        curv(i) = curv(i)/max(startToEnd);
    end
    title(['' num2str(sum(curv))]);
    disp(['Total Curvature Approximation: ' num2str(sum(curv))]);
    drawnow;
    
end

%save_figures(fig, './', ['fff_'], 12, [10 6]);