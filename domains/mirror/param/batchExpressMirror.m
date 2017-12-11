function mirrorFV = batchExpressMirror(genome, repParams)
%% Assumes that all input genomes are valid -- check before!

parfor i=1:size(genome,1)
    mirrorFV(i) = mirror_param_Express(genome(i,:), repParams);
end