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


[~,help] = system('LosSegmentatores\elastix\elastix.exe --help')

[~,elastix_version] = system('LosSegmentatores\elastix\elastix.exe --version')



%% Registratio - RIGID AND AFFINE + masked affine

% create TempFile, define the parameters and paths
rmdir("C:\Users\xnantl01\MPA-AB2\Lecture5_23\LosSegmentatores\TempFile\","s")
mkdir("C:\Users\xnantl01\MPA-AB2\Lecture5_23\LosSegmentatores\TempFile\")
fixedPath = "C:\Users\xnantl01\MPA-AB2\Lecture5_23\LosSegmentatores\TempFile\fixedImage.nii";
movingPath = "C:\Users\xnantl01\MPA-AB2\Lecture5_23\LosSegmentatores\TempFile\movingImage.nii";
outputPath = "C:\Users\xnantl01\MPA-AB2\Lecture5_23\LosSegmentatores\TempFile";
parametersPath = "C:\Users\xnantl01\MPA-AB2\Lecture5_23\LosSegmentatores\parameter_files\Parameters_Affine.txt";

niftiwrite(fixed,fixedPath)
niftiwrite(moving,movingPath)



% run ELASTIX
[~,cmdOut] = system("C:\Users\xnantl01\MPA-AB2\Lecture5_23\LosSegmentatores\elastix\elastix.exe -f "+ fixedPath + " -m " + movingPath + " -out " + outputPath + " -p " + parametersPath);
disp(cmdOut)




% read resulting nii a save to variable - registered

registered = niftiread("C:\Users\xnantl01\MPA-AB2\Lecture5_23\LosSegmentatores\TempFile\result.0.nii");




%% display
subplot(1,3,3)
imshow(registered,[])
title('Registered')

figure
subplot(1,2,1)
imshowpair(fixed,moving)
subplot(1,2,2)
imshowpair(fixed,registered)
