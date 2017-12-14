%RUNFOAMTEST - Test whether the mirror representation can be automatically
%run through OpenFOAM on the cluster
%
% Other m-files required: /sail/defaultParamSet.m, <domainName>_Domain.m
% Other submodules required: gpml
% For domain requirements see domains/<domainName>/Content.m
%
% Author: Alexander Hagg
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: alexander.hagg@h-brs.de
% dec 2017; Last revision: 14-Dec-2017

%------------- BEGIN CODE --------------
% Clean up workspace and add relevant files to path
clear;
currentPath = mfilename('fullpath');
addpath(genpath(currentPath(1:end-length(mfilename))));


%% Generate shape and run OpenFOAM

% Get domain
d = mirror_Domain('nCases',1);
% Get base and random shape
observations(1,:) = 0.5+0.0*rand(1,41);
observations(2,:) = 0.45+0.1*rand(1,41);

%% Run OpenFoam
runTime = tic;
[values] = feval(d.preciseEvaluate, observations , d); 
disp(['Runtime: ' seconds2human(toc(runTime))]);

% Save results
save(['foamTest.mat'],'observations', 'values','p','d');

