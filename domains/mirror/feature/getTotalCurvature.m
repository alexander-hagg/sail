function meanCurvature = getTotalCurvature(mirror, d)
%getTotalCurvature - Returns total curvature of a set of 2D lines
%
% Syntax:  [totalCurvature] = getTotalCurvature(mirror, d)
%
% Inputs:
%    mirror     - [Npoints X 3] - X,Y,Z coordinates of each point in design
%    d - domain      - Ids of points in line for curvature
%
% Outputs:
%    meanCurvature - [scalar] - Mean curvature of all lines in 2D
%
% Example:
%   d = mirror_Domain; % for point IDs
%   FV = mirror_ffd_Express(0.5 + zeros(1,41), d.FfdP)
%   meanCurvature = getTotalCurvature(FV.vertices, d.curvSecIds)
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%

% Author: Alexander Hagg
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: alexander.hagg@h-brs.de
% Dec 2017; Last revision: 12-Dec-2017

%%------------- BEGIN CODE --------------

planes = logical([1 1 0; 1 0 1; 0 1 1]);

%% Get length relative curvature and length of each line
for i=1:length(d.features.curvature.ids)
    line = mirror(:,d.features.curvature.ids{i});
    for p=1:size(planes,1)
        lineCurv                    = LineCurvature2D(line(planes(p,:),:)');
        lineDiff                    = diff(line(planes(p,:),:));
        lineLength                  = sum (sqrt (sum (lineDiff.*lineDiff,2) ) );
        curvature((i-1)*3 + p)      = nanmean(abs(lineCurv)).*lineLength;
    end
end

meanCurvature = mean(curvature);

%------------- END OF CODE --------------











