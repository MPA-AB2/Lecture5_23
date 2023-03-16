%% registration elastix-2D

clear all
close all
clc

load data1.mat
% load data2.mat

figure
subplot(1,3,1)
imshow(fixed,[])
title('Fixed')
subplot(1,3,2)
imshow(moving,[])
title('Moving')


[~,help] = system('elastix\elastix.exe --help')

[~,elastix_version] = system('elastix\elastix.exe --version')



% Registratio - RIGID AND AFFINE + masked affine
% create TempFile, define the parameters and paths

% Set the directory path
dirpath = 'TempFile';

% Delete all files in the directory
delete(fullfile(dirpath, '*'));

fixedImg = ("fixed1.nii");
movingImg = ("moving1.nii");


outputDirectory = ("TempFile");
parameterFile = ("parameter_files/Parameters_Rigid.txt");

% elastix -f fixedImage.ext -m movingImage.ext -out outputDirectory -p parameterFile.txt
cmd = append('elastix\elastix.exe', ' -f ', fixedImg, ' -m ', movingImg, ' -out ', outputDirectory, ' -p ', parameterFile);


% run ELASTIX

system(cmd);



%% read resulting nii a save to variable - registered
registered = niftiread('TempFile/result.0.nii');
% imshow(result1,[])

% display
subplot(1,3,3)
imshow(registered,[])
title('Registered')

figure
subplot(1,2,1)
imshowpair(fixed,moving)
subplot(1,2,2)
imshowpair(fixed,registered)


%% Registratio - RIGID AND AFFINE + masked affine TRANSFORMIX
% create TempFile, define the parameters and paths
% clear
% Set the directory path
dirpath = 'TempFile';

% Delete all files in the directory
delete(fullfile(dirpath, '*'));

outputDirectory = ("TempFile");
parameterFile = ("parameter_files/Parameters_Rigid.txt");
inputFile = ("parameter_files/TransformParameters.0.txt");
% movingImg = ("parameter_files/result.0.nii");
% elastix -f fixedImage.ext -m movingImage.ext -out outputDirectory -p parameterFile.txt

cmd = append('elastix\transformix.exe', ' -def all -out ', outputDirectory, ' -tp ', inputFile);
% cmd = append('elastix\elastix.exe', ' -f ', fixedImg, ' -m ', movingImg, ' -out ', outputDirectory, ' -p ', parameterFile);
% run TRANSFORMIX
system(cmd);
%
deformation = niftiread('TempFile/deformationField.nii');
imshow(deformation(:,:,:,1,1),[])
