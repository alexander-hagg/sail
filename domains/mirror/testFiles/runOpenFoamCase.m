% Get domain
d = mirror_Domain('nCases',1);
% Get shape
observation = 0.5+0.0*rand(1,41);


%% Run OpenFoam
d.openFoamTemplate = ['/home/alex/sail/domains/' d.namebase '/pe/ofTemplates/4core/'];
d.openFoamFolder = ['/home/alex/sail/domains/' d.namebase '/pe/'];
for iCase = 1:d.nCases
    system(['cp -r ' d.openFoamTemplate ' ' d.openFoamFolder 'case' int2str(iCase)]); 
end

%system(['cd ' d.openFoamFolder ]);
%system(['./startCaseRunners.sh']);


%%
[value] = mirror_PreciseEvaluate(observation, d);