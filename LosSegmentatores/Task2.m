%% registration elastix-2D

clear all
close all
clc



%load data1.mat
load data2.mat

figure
subplot(1,3,1)
imshow(fixed,[])
title('Fixed')
subplot(1,3,2)
imshow(moving,[])
title('Moving')


[~,help] = system('elastix\elastix.exe --help');

[~,elastix_version] = system('elastix\elastix.exe --version');



%% Registratio - RIGID AND AFFINE + masked affine

if exist(".\TempFile\")
    rmdir(".\TempFile\",'s')
    mkdir(".\TempFile\")
end

% create TempFile, define the parameters and paths
f_path = ".\TempFile\fixedImage.nii";
m_path = ".\TempFile\movingImage.nii";
out_path = ".\TempFile\";
p_path = ".\parameter_files\Parameters_Affine.txt";
mMask_path = ".\tempFile\movingMask.nii";

niftiwrite(fixed,f_path)
niftiwrite(moving,m_path)

% binary mask
bw = moving>0;

niftiwrite(uint8(bw),mMask_path)

% run ELASTIX
system(".\elastix\elastix.exe -f " + f_path + " -m " + m_path + " -out " + out_path + " -p " + p_path + " -mMask " + mMask_path)


%% read resulting nii a save to variable - registered
registered = niftiread(fullfile(out_path,"result.0.nii"));

% display
subplot(1,3,3)
imshow(registered,[])
title('Registered')

figure
subplot(1,2,1)
imshowpair(fixed,moving)
subplot(1,2,2)
imshowpair(fixed,registered)
% saving deformation map
system(".\elastix\transformix.exe -def all -out " + out_path + " -tp " + fullfile(out_path,"TransformParameters.0.txt"))

% copyfile(fullfile(path_data,folders{i},"deformationField.nii"),fullfile(out_path,"deformationField_Est.nii"))