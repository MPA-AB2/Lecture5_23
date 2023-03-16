%% evaluation

function [MSE,STD] = eval_lung(path_DF)

D = dir([path_DF '\**\deformationField_Est.nii']);

MSE = [];
STD = [];
for i = 1:length(D)

    DF_GT = niftiread( [D(i).folder '\' D(i).name ]);
    DF_est = niftiread([D(i).folder '\' replace(D(i).name,'_Est','' ) ]);
    
    MSE(i) = ((mean((squeeze(DF_GT(:,:,:,:,1))-squeeze(DF_est(:,:,:,:,1))).^2,'all')) ...
        + (mean((squeeze(DF_GT(:,:,:,:,2))-squeeze(DF_est(:,:,:,:,2))).^2,'all'))) /2;
    
    STD(i) = ((var((squeeze(DF_GT(:,:,:,:,1))-squeeze(DF_est(:,:,:,:,1))),[],'all') ...
        + var((squeeze(DF_GT(:,:,:,:,1))-squeeze(DF_est(:,:,:,:,1))),[],'all'))  )/2;

end

MSE = mean(MSE);
STD = mean(STD);

