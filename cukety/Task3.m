%% registrace s eval

clear all
close all
clc

filename = 'Data\Data\pat01\fixed.nii';
fixed = niftiread(filename);

filename = 'Data\Data\pat01\moving.nii';
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
pth_to_folder = "C:\Users\xmarti91\AB2\Lecture5_23\cukety";

pth_final = "elastix\elastix.exe -f "+  pth_to_folder + ...
    "\Data\Data\pat01\fixed.nii -m "+pth_to_folder+"\Data\Data\pat01\moving.nii -p " + ...
    pth_to_folder + "\parameter_files\Parameters_Affine.txt -out "+ ...
    pth_to_folder+"\TempFile";

system(pth_final );

pth_elastic = "elastix\transformix.exe -def all -out "+pth_to_folder+"\TempFile -tp "+ pth_to_folder+"\TempFile\TransformParameters.0.txt";

system(pth_elastic)

%% load result nifti

path_result = pth_to_folder+"\TempFile";
registered = niftiread(path_result +"\result.0.nii");

%% evaluation 

path_Def_GT = 'Data\Data\pat01\deformationField.nii';
path_Def_Est = 'TempFile\deformationField.nii'; 

[MSE,STD] = eval_lung('Data\Data\')


%% display

figure(2)
subplot(1,2,2)
imshowpair(fixed, registered)
