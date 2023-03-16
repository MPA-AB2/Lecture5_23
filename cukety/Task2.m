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


% [~,help] = system('elastix\elastix.exe --help')
% 
% [~,elastix_version] = system('elastix\elastix.exe --version')

pth_to_folder = "C:\Users\xmikes13\Desktop\Lecture5_23\cukety";


%% Registratio - RIGID AND AFFINE + masked affine

% create TempFile, define the parameters and paths
niftiwrite(fixed,"TempFile\fixed.nii");
niftiwrite(moving,"TempFile\moving.nii");

mask = moving;
mask(mask > 0) = 1;
imshow(mask,[])
niftiwrite(mask,"TempFile\mask.nii")
% run ELASTIX

pth_final = "elastix\elastix.exe -f "+  pth_to_folder + ...
    "\TempFile\fixed.nii -m "+pth_to_folder+"\TempFile\moving.nii -p " + ...
    pth_to_folder + "\parameter_files\Parameters_Affine.txt -out "+ ...
    pth_to_folder+"\TempFile\res" + " -mMask "+ pth_to_folder+"\TempFile\mask.nii";

system(pth_final );




% read resulting nii a save to variable - registered
registered = niftiread(pth_to_folder+"\TempFile\res\result.0.nii");




%% display
subplot(1,3,3)
imshow(registered,[])
title('Registered')

figure
subplot(1,2,1)
imshowpair(fixed,moving)
subplot(1,2,2)
imshowpair(fixed,registered)
