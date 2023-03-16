%% registrace s eval

clear all
close all
clc

filename = 'Data\pat01\fixed.nii';
fixed = niftiread(filename);

filename = 'Data\pat01\moving.nii';
moving = niftiread(filename);

figure
subplot(1,3,1)
imshow(fixed,[])
title('Refer')
subplot(1,3,2)
imshow(moving,[])
title('Moving')

figure(2)
subplot(1,2,1)
imshowpair(fixed,moving)



%% Registration

% registratio by Elastix



% load result nifti
path_result = 'add path to result nifti file';
registered = niftiread([path_result '\result.0.nii']);

%% evaluation 

path_Def_GT = 'Data\pat01\deformationField.nii';

[MSE,STD] = eval_lung([path_Def_GT], [path_Def_Est])


%% display

figure(2)
subplot(1,2,2)
imshowpair(fixed, registered)
