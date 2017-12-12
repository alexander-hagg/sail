function [feature] = mirror_Categorize(samples, d)
%velo_Categorize - Returns feature values between 0 and 1 for each dimension
%
% Syntax:  [feature] = veloFfd_Categorize(samples, d)
%
% Inputs:
%   samples  -  [NX1] - uncategorized solutions as vector of FV structs
%                     - NOTE: these must be valid shapes, check before!
%   d        -  Domain description struct
%   .featureMin [1X1]   - minimum feature value
%   .featureMax [1X1]   - maximum feature value
%
% Outputs:
%    feature - [MXN] - Feature values for each individual
%

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: adam.gaier@h-brs.de
% Sep 2017; Last revision: 25-Sep-2017

%------------- BEGIN CODE --------------
nSamples= size(samples,1);
feature = nan(nSamples,2);
veloFV = d.express(samples);

parfor i=1:size(samples,1)
    if any(isnan(veloFV(i).vertices(:))); error(['Can''t categorize NaN.']); end
    % FEATURE Curvature
    feature1(i) = getTotalCurvature(veloFV(i).vertices,d.verticeIDs);    
    % FEATURE RelativeLength
    %feature2(i) = getTotalCurvature(veloFV(i).vertices,d.verticeIDs);    
    % FEATURE MirrorSurface
    %feature3(i) = getTotalCurvature(veloFV(i).vertices,d.verticeIDs);    
end
feature = [feature1(:) feature2(:)];


feature = (feature-d.featureMin)./(d.featureMax-d.featureMin);
feature(feature>1) = 1; feature(feature<0) = 0;

%------------- END OF CODE --------------
